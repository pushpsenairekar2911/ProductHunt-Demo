//
//  Extenions.swift
//  Product Hunt Demo
//
//  Created by pushpsen airekar on 25/01/20.
//  Copyright © 2020 pushpsen airekar. All rights reserved.
//

import UIKit
import Foundation

extension UIView {

    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
