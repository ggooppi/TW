//
//  ProductDetailViewModel.swift
//  TWWorkshop
//
//  Created by gopinath.a on 21/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewModel: NSObject {
    var selectedProduct = ShopperList()
    
    func getPrice() -> String {
        return selectedProduct.offerPrice.isEmpty ? selectedProduct.price : selectedProduct.offerPrice
    }
    
    func getColorForPrice() -> UIColor  {
        return selectedProduct.offerPrice.isEmpty ? UIColor.lightGray : UIColor.red
    }
    
    func getImagefor(productImageView: UIImageView) {
        Webservice.shared.getImageFrom(url: selectedProduct.image, for: productImageView)
    }
    
    
}
