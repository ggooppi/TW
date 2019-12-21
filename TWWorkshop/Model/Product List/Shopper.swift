//
//  Shopper.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import ObjectMapper

class ShopperList: Codable, Mappable{
    var pid = ""
    var name = ""
    var price = ""
    var offerPrice = ""
    var image = ""
    var desc = ""
    
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

struct ProductTableCellData {
    let id: String
    let name: String
    let price: String
    let priceColor: UIColor
    let productImage: String
    let wishList: Int
}

struct WishlistData {
    let items: Int
    let totalSavings: String
    let total: String
}
