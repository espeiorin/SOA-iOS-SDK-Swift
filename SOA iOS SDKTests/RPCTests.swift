//
//  RPCTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 18/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest

class RPCTests: XCTestCase {
    
    let baseURL = URL(string: "http://example.com")
    let call = "remote-call"
    lazy var targetURL: URL? = {
        return self.baseURL?.appendingPathComponent(self.call.lowercased())
    }()
    let mockData = RestMockData()
    var restClient: RestMock!
    
    override func setUp() {
        super.setUp()
        restClient = RestMock(mockData: mockData)
        SOAManager.shared.restClient = restClient
        SOAManager.shared.restURL = URL(string: "http://google.com")
        SOAManager.shared.rpcURL = baseURL
    }
    
    override func tearDown() {
        SOAManager.shared.tearDown()
        super.tearDown()
    }
    
    func testMultipleResultCall() {
        restClient.completionData[.post] = mockedMultipleResultfullCall()
        SOAManager.shared.restClient = restClient
        
        let remoteCall = RemoteProcedureCall<ObjectMock>(procedure: call)
        let params = ["max-id": 10]
        let multipleResultExpectation = expectation(description: "Success Call")
        remoteCall.execute(params: params) { result, error in
            XCTAssertEqual(self.mockData.requestURL, self.targetURL)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 2)
            XCTAssertNil(error)
            multipleResultExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testSingleResultCall() {
        restClient.completionData[.post] = mockedSingleResultfullCall()
        SOAManager.shared.restClient = restClient
        
        let remoteCall = RemoteProcedureCall<ObjectMock>(procedure: call)
        let params = ["max-id": 10]
        let singleResultExpectation = expectation(description: "Success Call")
        remoteCall.execute(params: params) { result, error in
            XCTAssertEqual(self.mockData.requestURL, self.targetURL)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 1)
            XCTAssertNil(error)
            singleResultExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testEmptyCall() {
        restClient.completionData[.post] = mockedEmptyCall()
        SOAManager.shared.restClient = restClient
        
        let remoteCall = RemoteProcedureCall<ObjectMock>(procedure: call)
        let params = ["max-id": 10]
        let emptyExpectation = expectation(description: "Empty Call")
        remoteCall.execute(params: params) { result, error in
            XCTAssertEqual(self.mockData.requestURL, self.targetURL)
            XCTAssertNil(result)
            XCTAssertNil(error)
            emptyExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testFailedCall() {
        restClient.completionData[.post] = mockedFailedCall()
        SOAManager.shared.restClient = restClient
        
        let remoteCall = RemoteProcedureCall<ObjectMock>(procedure: call)
        let params = ["max-id": 10]
        let failExpectation = expectation(description: "Failed Call")
        remoteCall.execute(params: params) { result, error in
            XCTAssertEqual(self.mockData.requestURL, self.targetURL)
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "Unauthorized")
            failExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testVersionedCall() {
        restClient.completionData[.post] = mockedSingleResultfullCall()
        SOAManager.shared.restClient = restClient
        
        let remoteCall = RemoteProcedureCall<ObjectMock>(procedure: call, version: SOAVersion(rawValue: "v2"))
        let params = ["max-id": 10]
        let singleResultExpectation = expectation(description: "Success Call")
        remoteCall.execute(params: params) { result, error in
            XCTAssertEqual(self.mockData.requestURL, self.baseURL?.appendingPathComponent("v2").appendingPathComponent(self.call))
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count, 1)
            XCTAssertNil(error)
            singleResultExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

extension RPCTests {
    func mockedMultipleResultfullCall() -> NetworkResponse {
        let data = "[{\"id\":10}, {\"id\":11}]".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    func mockedSingleResultfullCall() -> NetworkResponse {
        let data = "{\"id\":10}".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    func mockedEmptyCall() -> NetworkResponse {
        return NetworkResponse(httpCode: 200, result: nil, error: nil)
    }
    
    func mockedFailedCall() -> NetworkResponse {
        let userInfo = [NSLocalizedDescriptionKey:"Unauthorized"]
        let error = NSError(domain: "me.andregustavo.soa", code: 401, userInfo: userInfo)
        return NetworkResponse(httpCode: 401, result: nil, error: error)
    }
}
