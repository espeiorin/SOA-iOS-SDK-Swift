//
//  SOAJoinTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest
import SOA

class SOAJoinTests: XCTestCase {
    
    
    func testJoin() {
        let filter = SOAFilter(condition: .equal, field: "id", value: "10")
        let join = SOAJoin(field: "test", filter: filter)
        XCTAssertEqual("\(join)", "test:id:eq:10")
    }
    
}
