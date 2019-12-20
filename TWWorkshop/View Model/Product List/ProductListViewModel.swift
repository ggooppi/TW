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
    
    var productListData = [ShopperList]()
    private let persistencyManager = PersistencyManager()
    
    weak var dataSource: NetworkCallHandler?
    
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
    
    func updateWishist(for id: String, eventType: WishlistEvent) -> Void {
        let value = UserDefaults.standard.integer(forKey: id)
        switch eventType {
        case .increase:
            UserDefaults.standard.set(value + 1, forKey: id)
        case .decrease:
            if value != 0{
                UserDefaults.standard.set(value - 1, forKey: id)
            }
        }
        
    }
}
