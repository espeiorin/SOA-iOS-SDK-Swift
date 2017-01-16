//
//  SOAQueryTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest

class SOAQueryTests: XCTestCase {
    
    let baseURL = URL(string: "http://example.com")
    let entity = "Entity"
    lazy var targetURL: URL? = {
        return self.baseURL?.appendingPathComponent(self.entity.lowercased())
    }()
    let mockData = RestMockData()
    
    override func setUp() {
        super.setUp()
        var restClient = RestMock(mockData: mockData)
        restClient.completionData[.get] = mockedResponse()
        SOAManager.shared.restClient = restClient
        SOAManager.shared.restURL = baseURL
    }
    
    private func mockedResponse() -> RESTResponse {
        let data = "[{\"id\":29}, {\"id\":30}]".data(using: .utf8)
        return RESTResponse(httpCode: 200, result: data, error: nil)
    }
    
    private func mockedFailedResponse() -> RESTResponse {
        let error = NSError(domain: "me.andregustavo.soa", code: 404, userInfo: [NSLocalizedDescriptionKey:"Not found"])
        return RESTResponse(httpCode: 404, result: nil, error: error)
    }
    
    override func tearDown() {
        SOAManager.shared.tearDown()
        super.tearDown()
    }
    
    func testSimpleQuery() {
        let query = SOAQuery<ObjectMock>(entity: entity)
        
        let queryExpectation = expectation(description: "QUERY CALL")

        query.execute { result, error in
            XCTAssertNotNil(result?.records)
            XCTAssertEqual(result?.records.count, 2)
            let firstItem = result?.records.first
            XCTAssertNotNil(firstItem)
            XCTAssertEqual(firstItem?.id, 29)
            let secondItem = result?.records[1]
            XCTAssertNotNil(secondItem)
            XCTAssertEqual(secondItem?.id, 30)
            XCTAssertNil(error)
            queryExpectation.fulfill()
        }
        
        XCTAssertEqual(mockData.requestMethod, HTTPMethod.get)
        XCTAssertEqual(mockData.requestURL, targetURL)
        
        XCTAssertNotNil(mockData.requestParams)
        XCTAssert(mockData.requestParams?.count == 0)
        
        XCTAssertNotNil(mockData.requestHeaders)
        XCTAssert(mockData.requestHeaders?.count == 0)
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func testCompleteQuery() {
        var query = SOAQuery<ObjectMock>(entity: entity, fields: ["id", "children"], offset: 10, limit: 20)
        query.append(filter: SOAFilter(condition: .greaterOrEqual, field: "id", value: "10"))
        query.append(filter: SOAFilter(condition: .lowerOrEqual, field: "id", value: "100"))
        
        let joinFilter = SOAFilter(condition: .equal, field: "id", value: "30")
        query.append(join: SOAJoin(field: "children", filter: joinFilter))
        
        let queryExpectation = expectation(description: "Query With Filter")
        
        query.execute { result, error in
            XCTAssertNotNil(result?.records)
            XCTAssertEqual(result?.records.count, 2)
            let firstItem = result?.records.first
            XCTAssertNotNil(firstItem)
            XCTAssertEqual(firstItem?.id, 29)
            let secondItem = result?.records[1]
            XCTAssertNotNil(secondItem)
            XCTAssertEqual(secondItem?.id, 30)
            XCTAssertNil(error)
            queryExpectation.fulfill()
        }
        
        XCTAssertEqual(mockData.requestMethod, HTTPMethod.get)
        XCTAssertEqual(mockData.requestURL, targetURL)
        
        XCTAssertNotNil(mockData.requestParams)
        XCTAssertEqual(mockData.requestParams?.count, 5)
        
        let fields = mockData.requestParams?["fields"] as? String
        XCTAssertNotNil(fields)
        XCTAssertEqual(fields, "id,children")
        
        let offset = mockData.requestParams?["offset"] as? Int
        XCTAssertNotNil(offset)
        XCTAssertEqual(offset, 10)
        
        let limit = mockData.requestParams?["limit"] as? Int
        XCTAssertNotNil(limit)
        XCTAssertEqual(limit, 20)
        
        let filters = mockData.requestParams?["filters"] as? String
        XCTAssertNotNil(filters)
        XCTAssertEqual(filters, "id:gte:10,id:lte:100")
        
        let join = mockData.requestParams?["join"] as? String
        XCTAssertNotNil(join)
        XCTAssertEqual(join, "children:id:eq:30")
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
