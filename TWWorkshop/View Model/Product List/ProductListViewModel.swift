//
//  BaseViewModel.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import ObjectMapper

protocol NetworkCallHandler: class {
    func dataFetched() -> Void
    func failedToFetchData(error: String) -> Void
}

enum WishlistEvent {
    case increase
    case decrease
}

class ProductListViewModel: NSObject {
    
    //MARK: - Properties
    var productListData = [ShopperList]()
    private let persistencyManager = PersistencyManager()
    
    weak var dataSource: NetworkCallHandler?
    
    private var wishlist = [String: Int]()
    
    static let shared = ProductListViewModel()
    
    private override init() {
    }
    
    //MARK: - Logical Functions
    func getData() -> [ShopperList] {
        productListData = persistencyManager.getData()
        return productListData
    }
    
    func getProductList() -> Void {
        
        Webservice.shared.getProductList {[unowned self] (status, response, error) in
            
            guard let dataSource = self.dataSource else {
              return
            }
            
            if status{
                guard let parsedData = self.parseData(responseObject: response!) else{
                    dataSource.failedToFetchData(error: NetworkError.failedToParse.rawValue)
                    return
                }
                self.productListData = parsedData
                self.processWishlist()
                dataSource.dataFetched()
            }else{
                dataSource.failedToFetchData(error: NetworkError.failedToParse.rawValue)
            }
        }
    }
    
    private func parseData(responseObject: [[String: Any]]) -> [ShopperList]?{
        if let data = Mapper<ShopperList>().mapArray(JSONObject: responseObject) {
            return data
        }
        return nil
    }
}

//MARK: - Extensions
extension ProductListViewModel{
    func getCellDataFor(product: ShopperList) -> ProductTableCellData {
        var priceToShow = product.price
        var colorForPrice = UIColor.gray
        let wishListCount = UserDefaults.standard.integer(forKey: product.pid)
        
        if !product.offerPrice.isEmpty{
            priceToShow = product.offerPrice
            colorForPrice = .red
        }
        
        return ProductTableCellData(id: product.pid, name: product.name, price: priceToShow, priceColor: colorForPrice, productImage: product.image, wishList: wishListCount)
    }
    
    func updateWishist(for id: String, eventType: WishlistEvent) {
        let value = UserDefaults.standard.integer(forKey: id)
        switch eventType {
        case .increase:
            UserDefaults.standard.set(value + 1, forKey: id)
            maintainWishlist(id: id, event: .increase)
        case .decrease:
            if value != 0{
                UserDefaults.standard.set(value - 1, forKey: id)
                maintainWishlist(id: id, event: .decrease)
            }
        }
        
    }
    
    private func maintainWishlist(id : String, event: WishlistEvent){
        switch event {
        case .increase:
            if let count = wishlist[id]{
                wishlist[id] = count + 1
            }else{
                wishlist[id] = 1
            }
        case .decrease:
            if let count = wishlist[id], count != 0{
                wishlist[id] = count - 1
            }else{
                wishlist[id] = 0
            }
        }
    }
    
    private func processWishlist() {
        productListData.forEach { (product) in
            let wishlistCount = UserDefaults.standard.integer(forKey: product.pid)
            wishlist[product.pid] = wishlistCount
        }
    }
    
    private func getProductWith(id: String) -> ShopperList?{
        var productToReturn: ShopperList? = nil
        var itemFound = false
        var index = 0
        while !itemFound && index < productListData.count {
            if productListData[index].pid == id{
                productToReturn = productListData[index]
                itemFound = true
            }else{
                index += index
            }
        }
        
        return productToReturn
    }
    
    func processWishlistData() -> WishlistData {
        var numberOfItems = 0
        var savings = 0
        var totalAmount = 0
        
        wishlist.forEach { (arg) in
            let (id, count) = arg
            numberOfItems = numberOfItems + count
            if count != 0{
                guard let productForID = getProductWith(id: id) else
                { return  }
                
                if !productForID.offerPrice.isEmpty{
                    savings = savings + (Utilities.shared.convertStringToInt(value: productForID.price) - Utilities.shared.convertStringToInt(value: productForID.offerPrice))
                    totalAmount = totalAmount + (Utilities.shared.convertStringToInt(value: productForID.offerPrice) * count)
                }else{
                    totalAmount = totalAmount + (Utilities.shared.convertStringToInt(value: productForID.price) * count)
                }
                
                
                
            }
        }
        
        return WishlistData(items: numberOfItems, totalSavings: "$\(savings)", total: "$\(totalAmount)")
    }
}
