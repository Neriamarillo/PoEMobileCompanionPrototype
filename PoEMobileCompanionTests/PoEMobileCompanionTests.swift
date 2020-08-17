//
//  PoEMobileCompanionTests.swift
//  PoEMobileCompanionTests
//
//  Created by Jorge Nieves on 8/11/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import XCTest

@testable import PoEMobileCompanionPrototype

class PoEMobileCompanionTests: XCTestCase {
    
    func testJsonDecoding() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Item", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            fatalError("Currency.json not found")
        }
        
        let decoder = JSONDecoder()
        guard let items = try? decoder.decode(ItemRoot.self, from: data) else {
            fatalError("Could not decode data")
        }
//        XCTAssertEqual((item.lines != nil), true)
        for item in items.lines! {
//            XCTAssertTrue(item.chaosEquivalent > 0)
//            XCTAssertTrue(item.chaosValue > 0)
            XCTAssertTrue(item.name != "")
        }
    }
    
//    func testModel() {
//        var itemModel: [ItemModel] = []
//        let item = ItemModel
//
//        itemModel.append(item)
//
//    }
    
}
