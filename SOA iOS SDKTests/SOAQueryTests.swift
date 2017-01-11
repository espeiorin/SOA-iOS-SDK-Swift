//
//  SOAQueryTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest
import SOA

fileprivate struct ObjectMock: JSONConvertible {
    init(dictionary: [String : Any]) {
        
    }
    
    fileprivate func dictionary() -> [String : Any] {
        return [:]
    }
}

class SOAQueryTests: XCTestCase {
    
    let baseURL = URL(string: "http://example.com")
    let entity = "Entity"
    lazy var targetURL: URL? = {
        return self.baseURL?.appendingPathComponent(self.entity.lowercased())
    }()
    let mockData = RestMockData()
    
    override func setUp() {
        super.setUp()
        let restClient = RestMock(mockData: mockData)
        SOAManager.shared.restClient = restClient
        SOAManager.shared.restURL = baseURL
    }
    
    override func tearDown() {
        SOAManager.shared.tearDown()
        super.tearDown()
    }
    
    func testSimpleQuery() {
        let query = SOAQuery<ObjectMock>(entity: "Entity")

        query.execute { result, error in
            
        }
        
        XCTAssertEqual(mockData.requestMethod, HTTPMethod.get)
        XCTAssertEqual(mockData.requestURL, targetURL)
        
        XCTAssertNotNil(mockData.requestParams)
        XCTAssert(mockData.requestParams?.count == 0)
        
        XCTAssertNotNil(mockData.requestHeaders)
        XCTAssert(mockData.requestHeaders?.count == 0)
    }
    
    func testQueryWithFilter() {
        
    }
    
    func testQueryWithJoin() {
        
    }
    
    func testCompleteQuery() {
        
    }
}
