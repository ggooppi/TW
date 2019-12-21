//
//  Utilities.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

class Utilities: NSObject {
    //MARK: - Properties
    static let shared = Utilities()
    
    private override init() {
    }
    
    func saveToUserDefaults(for key: String, with value: String) -> Void {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func convertStringToInt(value: String) -> Int {
        var valueToBeChanges = value
        valueToBeChanges = valueToBeChanges.replacingOccurrences(of: ",", with: "")
        valueToBeChanges = String(describing: valueToBeChanges.removeFirst()) 
        return Int(valueToBeChanges) ?? 0
    }
}
