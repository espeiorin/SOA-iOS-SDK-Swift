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
    var restClient: RestMock!
    
    override func setUp() {
        super.setUp()
        restClient = RestMock(mockData: mockData)
        restClient.completionData[.get] = mockedResponse()
        SOAManager.shared.restClient = restClient
        SOAManager.shared.restURL = baseURL
    }
    
    private func mockedResponse() -> NetworkResponse {
        let data = "[{\"id\":29}, {\"id\":30}]".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    private func mockedEmptyResponse() -> NetworkResponse {
        let data = Data(bytes: [0x00])
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    private func mockedFailedResponse() -> NetworkResponse {
        let error = NSError(domain: "me.andregustavo.soa", code: 404, userInfo: [NSLocalizedDescriptionKey:"Not found"])
        return NetworkResponse(httpCode: 404, result: nil, error: error)
    }
    
    override func tearDown() {
        SOAManager.shared.tearDown()
        super.tearDown()
    }
    
    func testSimpleQuery() {
        let query = Query<ObjectMock>(entity: entity)
        
        let queryExpectation = expectation(description: "QUERY CALL")

        query.execute { result, error in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 2)
            let firstItem = result?.first
            XCTAssertNotNil(firstItem)
            XCTAssertEqual(firstItem?.id, 29)
            let secondItem = result?[1]
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
        var query = Query<ObjectMock>(entity: entity, fields: ["id", "children"], offset: 10, limit: 20)
        query.append(filter: Filter(condition: .greaterOrEqual, field: "id", value: "10"))
        query.append(filter: Filter(condition: .lowerOrEqual, field: "id", value: "100"))
        
        let joinFilter = Filter(condition: .equal, field: "id", value: "30")
        query.append(join: Join(field: "children", filter: joinFilter))
        
        let queryExpectation = expectation(description: "Query With Filter")
        
        query.execute { result, error in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 2)
            let firstItem = result?.first
            XCTAssertNotNil(firstItem)
            XCTAssertEqual(firstItem?.id, 29)
            let secondItem = result?[1]
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
    
    func testEmptyQuery() {
        
        restClient.completionData[.get] = mockedEmptyResponse()
        SOAManager.shared.restClient = restClient
        
        let query = Query<ObjectMock>(entity: entity)
        let queryExpectation = expectation(description: "Empty Query")
        
        query.execute { result, error in
            XCTAssertNil(result)
            XCTAssertNil(error)
            queryExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testFailedQuery() {
        restClient.completionData[.get] = mockedFailedResponse()
        SOAManager.shared.restClient = restClient
        
        let query = Query<ObjectMock>(entity: entity)
        let queryExpectation = expectation(description: "Empty Query")
        
        query.execute { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            queryExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
