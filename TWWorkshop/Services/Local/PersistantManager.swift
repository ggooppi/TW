//
//  PersistantManager.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

final class PersistencyManager {
    
    private var shopperList = [ShopperList]()
    
    init() {
        let savedURL = documents.appendingPathComponent(Filenames.Mobiles)
        var data = try? Data(contentsOf: savedURL)
        if data == nil, let bundleURL = Bundle.main.path(forResource: Filenames.Mobiles, ofType: Filenames.type) {
            do {
                data = try Data(contentsOf: URL(fileURLWithPath: bundleURL), options: .mappedIfSafe)
            } catch {
                // handle error
            }
        }
        
        if let mobileData = data, let decodedList = try? JSONDecoder().decode([ShopperList].self, from: mobileData) {
            shopperList = decodedList
        }
    }
    
    private var documents: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private enum Filenames {
        static let Mobiles = "sampleJSON"
        static let type = "json"
    }
    
    func getData() -> [ShopperList] {
        return shopperList
    }
    
}
