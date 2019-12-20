//
//  Shopper.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct ShopperList: Codable {
    var pid: String
    var name: String
    var price: String
    var offerPrice : String? = ""
    var image: String
    var desc: String
}
