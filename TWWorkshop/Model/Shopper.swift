//
//  Shopper.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import ObjectMapper

class ShopperList: NSObject, Codable, Mappable{
    var pid = ""
    var name = ""
    var price = ""
    var offerPrice : String? = ""
    var image = ""
    var desc = ""
    
    struct ListTableData {
        let id: String
        let title: String
        let des: String
        let desColor: UIColor
        let image: String
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        pid <- map["pid"]
        name <- map["name"]
        price <- map["price"]
        offerPrice <- map["offerPrice"]
        image <- map["image"]
        desc <- map["desc"]
    }
}

extension ShopperList{
    func getTableData() -> ListTableData {
        return ListTableData(id: self.pid, title: self.name, des: self.offerPrice != "" ? self.offerPrice! : self.price, desColor: self.offerPrice != "" ? UIColor.red : UIColor.gray, image: self.image)
    }
}
