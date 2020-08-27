//
//  UIColor+Palette.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public static var ibColor: UIColor {
        return UIColor(named: "ibColor") ?? systemPink
    }
    
    public static var amountTextColor: UIColor {
        return UIColor(named: "amountTextColor") ?? systemGray
    }
    
    public static var nameTextColor: UIColor {
        return UIColor(named: "nameTextColor") ?? systemGray2
    }
    
    public static var cellImageBackgroundColor: UIColor {
        return UIColor(named: "cellImageBackgroundColor") ?? systemGray2
    }
    
}
