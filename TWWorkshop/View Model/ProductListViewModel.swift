//
//  BaseViewModel.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductListViewModel {
    
    var productListData = [ShopperList]()
    
    private let persistencyManager = PersistencyManager()
    
    func getData() -> [ShopperList] {
        productListData = persistencyManager.getData()
        return productListData
    }
    
    func getProductList(completionHandler: @escaping (_ status:Bool, _ error: String?) -> Void) -> Void {
        
        Webservice.shared.getProductList { (status, response, error) in
            if status{
                if let parsedData = self.parseData(responseObject: response!){
                    self.productListData = parsedData
                    completionHandler(true, nil)
                }else{
                     completionHandler(false, error)
                }
            }else{
                completionHandler(false, error)
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
