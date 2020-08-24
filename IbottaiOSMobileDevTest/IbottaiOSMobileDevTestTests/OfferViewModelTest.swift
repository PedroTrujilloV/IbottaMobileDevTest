//
//  OfferViewModelTest.swift
//  IbottaiOSMobileDevTestTests
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import XCTest
@testable import IbottaiOSMobileDevTest

class OfferViewModelTest: XCTestCase {

    var dictionary2 = [ "id" : "110580",
    "url" : "https://product-images.ibotta.com/offer/OS0MnVcHXe7snozDC7nIiw-normal.png",
    "name" : "Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges",
    "description" : "Any variety - 2 ct. pack or larger",
    "terms" : "Rebate valid on Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges for any variety, 2 ct. pack or larger.",
    "current_value" : "$0.75 Cash Back"]
    
    var dictionary3:[String:String]!
    
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
    
    func testNotNil() {
        dictionary3 = dictionary2
        dictionary3["id"] = nil
        dictionary3["url"] = nil
        dictionary3["name"] = nil
        dictionary3["description"] = nil
        dictionary3["terms"] = nil
        dictionary3["current_value"] = nil
        guard let givenOffer = OfferModelTest.offerFrom(dictionary: dictionary3) else {  return }
        let whenOfferVM = OfferViewModel(model: givenOffer)

        XCTAssertNotNil(whenOfferVM.id)
        XCTAssertNotNil(whenOfferVM.url)
        XCTAssertNotNil(whenOfferVM.name)
        XCTAssertNotNil(whenOfferVM.description)
        XCTAssertNotNil(whenOfferVM.terms)
        XCTAssertNotNil(whenOfferVM.current_value)
    }
    
    func testEquality(){
        guard let givenOffer = OfferModelTest.offerFrom(dictionary: dictionary2) else { return }
        let whenOfferVM = OfferViewModel(model: givenOffer)

        //Refactor: currently satisfies the test for now but necessary change the right strings according the output from the VM
        XCTAssertTrue(whenOfferVM.id == self.dictionary2["id"])
        XCTAssertTrue(whenOfferVM.url == self.dictionary2["url"])
        XCTAssertTrue(whenOfferVM.name == self.dictionary2["name"])
        XCTAssertTrue(whenOfferVM.description == self.dictionary2["description"])
        XCTAssertTrue(whenOfferVM.terms == self.dictionary2["terms"])
        XCTAssertTrue(whenOfferVM.current_value == self.dictionary2["current_value"])
    }
    
    func testInequality(){
        dictionary3 = dictionary2
        dictionary3["id"] = nil
        dictionary3["url"] = nil
        dictionary3["name"] = nil
        dictionary3["description"] = nil
        dictionary3["terms"] = nil
        dictionary3["current_value"] = nil

        guard let givenOffer = OfferModelTest.offerFrom(dictionary: dictionary3) else { return }
        let whenOfferVM = OfferViewModel(model: givenOffer)

        XCTAssertTrue(whenOfferVM.id != self.dictionary2["id"])
        XCTAssertTrue(whenOfferVM.url != self.dictionary2["url"])
        XCTAssertTrue(whenOfferVM.name != self.dictionary2["name"])
        XCTAssertTrue(whenOfferVM.description != self.dictionary2["description"])
        XCTAssertTrue(whenOfferVM.terms != self.dictionary2["terms"])
        XCTAssertTrue(whenOfferVM.current_value != self.dictionary2["current_value"])
    }

}
