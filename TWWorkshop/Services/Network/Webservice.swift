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
    
    //MARK: - Properties
    static let shared = Webservice()
    
    private override init() {
    }
    
    //MARK: - Functions
    func getProductList(completionHandler: @escaping ((Bool, [[String:Any]]?, String?) -> Void)) -> Void {
        
        Alamofire.request(NetworkURL.productList, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success(_):
                    guard let responseObject = response.result.value as? [[String:Any]] else{
                        completionHandler(false, nil, NetworkError.failedToParse.rawValue)
                        return
                    }
                    completionHandler(true, responseObject, nil)
                case .failure(_):
                    completionHandler(false, nil, NetworkError.somethingWentWrong.rawValue)
                }
        }
    }
    
    func getImageFrom(url: String, for imageView: UIImageView) -> Void {
        if let url = URL(string: url) {
            imageView.af_setImage(withURL: url)
        }
    }
    
}
