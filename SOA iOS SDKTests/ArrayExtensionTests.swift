//
//  ArrayExtensionTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest
import SOA

class ArrayExtensionTests: XCTestCase {
    
    func testRemove() {
        var array = ["a", "b", "c"]
        array.remove("a")
        XCTAssertNil(array.index(of: "a"))
        XCTAssertNotNil(array.index(of: "b"))
        XCTAssertNotNil(array.index(of: "c"))
    }
    
}
