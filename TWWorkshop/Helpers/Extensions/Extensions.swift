//
//  Extensions.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func roundedCorners(radius: CGFloat) -> Void {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
