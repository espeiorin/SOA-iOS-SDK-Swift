//
//  SOAFilterTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest
import SOA

class SOAFilterTests: XCTestCase {
    
    func testEqual() {
        let filter = Filter(condition: .equal, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:eq:value")
    }
    
    func testLike() {
        let filter = Filter(condition: .like, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:like:value")
    }
    
    func testLowerThan() {
        let filter = Filter(condition: .lowerThan, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:lt:value")
    }
    
    func testLowerOrEqual() {
        let filter = Filter(condition: .lowerOrEqual, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:lte:value")
    }
    
    func testGreaterThan() {
        let filter = Filter(condition: .greaterThan, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:gt:value")
    }
    
    func testGreaterOrEqual() {
        let filter = Filter(condition: .greaterOrEqual, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:gte:value")
    }
    
    func testNotEqual() {
        let filter = Filter(condition: .notEqual, field: "field", value: "value")
        XCTAssertEqual("\(filter)", "field:neq:value")
    }
    
}
