//
//  OfferModelTest.swift
//  IbottaiOSMobileDevTestTests
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import XCTest
@testable import IbottaiOSMobileDevTest

class OfferModelTest: XCTestCase {

    let dictionary1 = [ "id" : "110579",
    "url" : "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
    "name" : "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
    "description" : "Any variety - 2 ct. pack or larger",
    "terms" : "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
    "current_value" : "$0.75 Cash Back" ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    static func offerFrom(dictionary:Dictionary<String,String>) -> Offer? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        {
            do {
                let offer = try JSONDecoder().decode(Offer.self, from: jsonData)
                print("\nJSON offer.current_value:  \(String(describing: offer.current_value))")
                return offer
            } catch {
                print("\nERROR:", error)
            }
        }
        return nil
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
    
    func testNotNill(){
        let givenOffer = OfferModelTest.offerFrom(dictionary: dictionary1)
        XCTAssertNotNil(givenOffer?.id)
        XCTAssertNotNil(givenOffer?.url)
        XCTAssertNotNil(givenOffer?.name)
        XCTAssertNotNil(givenOffer?.description)
        XCTAssertNotNil(givenOffer?.terms)
        XCTAssertNotNil(givenOffer?.current_value)
    }
    
    func testEquality(){
        let givenOffer = OfferModelTest.offerFrom(dictionary: dictionary1)
        XCTAssertTrue(givenOffer?.id == self.dictionary1["id"])
        XCTAssertTrue(givenOffer?.url == self.dictionary1["url"])
        XCTAssertTrue(givenOffer?.name == self.dictionary1["name"])
        XCTAssertTrue(givenOffer?.description == self.dictionary1["description"])
        XCTAssertTrue(givenOffer?.terms == self.dictionary1["terms"])
        XCTAssertTrue(givenOffer?.current_value == self.dictionary1["current_value"])
    }
    
    

}
