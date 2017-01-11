//
//  DictionaryExtensionTests.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest
import SOA

class DictionaryExtensionTests: XCTestCase {
    
    let originalDictionary = ["a" : 12, "b" : 13]
    let appendDictionary = ["c" : 14, "a": 10]
    
    func testMergedDictionaries() {
        var modified = originalDictionary.merged(with: appendDictionary)
        
        XCTAssertEqual(modified["a"], 10)
        XCTAssertEqual(modified["b"], 13)
        XCTAssertEqual(modified["c"], 14)
    }
    
}
