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
        return UIColor(named: "ibColor") ?? .systemPink
    }
}
