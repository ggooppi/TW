//
//  BaseViewModel.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

class ProductListViewModel {
    private let persistencyManager = PersistencyManager()
    
    func getData() -> [ShopperList] {
        return persistencyManager.getData()
    }
}
