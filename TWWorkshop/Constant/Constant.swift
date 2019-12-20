//
//  Constant.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

//MARK: - Constant
struct CellIdentifiers {
    static let defaultCell = "cell"
    static let productListCell = "productListTableViewCell"
}

struct CellName {
    static let productListCell = "ProductListTableViewCell"
}

struct NetworkURL {
    static let productList = "http://www.mocky.io/v2/5dfb59e72f00006200ff9e80"
}

//MARK: - Error
enum NetworkError: String, Error{
    case somethingWentWrong = "Something Went Wrong"
    case failedToParse = "Failed to parse data"
}
