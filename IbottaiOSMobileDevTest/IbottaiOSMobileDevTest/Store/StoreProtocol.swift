//
//  StoreProtocol.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation

protocol StoreDelegate:AnyObject {
    func storeDidLoad(offers:Array<OfferViewModel>)
}
