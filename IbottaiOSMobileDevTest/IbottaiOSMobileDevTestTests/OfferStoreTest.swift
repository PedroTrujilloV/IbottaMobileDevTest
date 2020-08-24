//
//  OfferStoreTest.swift
//  IbottaiOSMobileDevTestTests
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import XCTest
import Combine
import SwiftUI

@testable import IbottaiOSMobileDevTest

class OfferStoreTest: XCTestCase, StoreDelegate{
    
    
   @ObservedObject var givenStore = OffersStore()
    var givenStore2 :OffersStore?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNotNilFRP() {
        let list = givenStore.objectList
        //sleep(3)
        print("\ncount: \(list.count)\n")
        list.forEach { (offerVM) in
            XCTAssertNotNil(offerVM)
        }
    }
    
    func testNotNilDelegate() {
        self.givenStore2 =  OffersStore(delegate: self)
       }
    
    func storeDidLoad(offers: Array<OfferViewModel>) {
        //then
        print("\noffers.count: \(offers.count)\n")
           offers.forEach { (offerVM) in
               XCTAssertNotNil(offerVM)
           }
    }

}
