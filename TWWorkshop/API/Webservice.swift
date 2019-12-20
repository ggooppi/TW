//
//  Webservice.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper

public class Webservice: NSObject {
    
    //MARK: Properties
    static let shared = Webservice()
    
    func getProductList(completionHandler: @escaping ((Bool, [[String:Any]]?, String?) -> Void)) -> Void {
        
        Alamofire.request(NetworkURL.productList, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success(_):
                    if let responseObject = response.result.value as? [[String:Any]]{
                        completionHandler(true, responseObject, nil)
                    }
                case .failure(_):
                    completionHandler(false, nil, nil)
                }
        }
    }
    
}
