//
//  SOAObjectTests.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import XCTest

class SOAObjectTests: XCTestCase {
    
    let baseURL = URL(string: "http://example.com")
    let entity = "ObjectMock"
    lazy var targetURL: URL? = {
        return self.baseURL?.appendingPathComponent(self.entity.lowercased())
    }()
    let mockData = RestMockData()
    var restClient: RestMock!
    
    override func setUp() {
        super.setUp()
        restClient = RestMock(mockData: mockData)
        restClient.completionData[.get] = mockedFetch()
        restClient.completionData[.post] = mockedSave()
        restClient.completionData[.put] = mockedUpdate()
        restClient.completionData[.delete] = mockedDelete()
        SOAManager.shared.restClient = restClient
        SOAManager.shared.restURL = baseURL
    }
    
    override func tearDown() {
        SOAManager.shared.tearDown()
        super.tearDown()
    }
    
    func testObjectFetch() {
        var object = ObjectMock()
        object.id = 10
        let fetchExpectation = expectation(description: "Fetch Object")
        object.fetch { (object, error) in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock/10"))
            XCTAssertNotNil(object)
            XCTAssertEqual(object?.id, 10)
            XCTAssertNil(error)
            fetchExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectFetchFail() {
        restClient.completionData[.get] = mockedFailedFetch()
        SOAManager.shared.restClient = restClient
        
        var object = ObjectMock()
        object.id = 10
        let fetchExpectation = expectation(description: "Fetch Object")
        object.fetch { (object, error) in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock/10"))
            XCTAssertNil(object)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "Not Found")
            fetchExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectSave() {
        var object = ObjectMock()
        let saveExpectation = expectation(description: "Save new Object")
        object.save { object, error in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock"))
            XCTAssertNotNil(object)
            XCTAssertEqual(object?.id, 11)
            XCTAssertNil(error)
            saveExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectSaveFail() {
        restClient.completionData[.post] = mockedFailedSave()
        SOAManager.shared.restClient = restClient
        
        var object = ObjectMock()
        let saveExpectation = expectation(description: "Save new Object")
        object.save { object, error in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock"))
            XCTAssertNil(object)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "Unauthorized")
            saveExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectUpdate() {
        var object = ObjectMock()
        object.id = 10
        let updateExpectation = expectation(description: "Update Object")
        object.save { object, error in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock/10"))
            XCTAssertNotNil(object)
            XCTAssertEqual(object?.id, 10)
            XCTAssertNil(error)
            updateExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectUpdateFail() {
        restClient.completionData[.put] = mockedFailedUpdate()
        SOAManager.shared.restClient = restClient
        
        var object = ObjectMock()
        object.id = 10
        let updateExpectation = expectation(description: "Update Object Failed")
        object.save { object, error in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock/10"))
            XCTAssertNil(object)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "Not Found")
            updateExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectDelete() {
        var object = ObjectMock()
        object.id = 10
        let deleteExpectation = expectation(description: "Delete Object")
        object.delete { error in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock/10"))
            XCTAssertNil(error)
            deleteExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func testObjectDeleteFail() {
        restClient.completionData[.delete] = mockedFailedDelete()
        SOAManager.shared.restClient = restClient
        var object = ObjectMock()
        object.id = 10
        let deleteExpectation = expectation(description: "Delete Object Faield")
        object.delete { error in
            XCTAssertEqual(self.mockData.requestURL, URL(string: "http://example.com/objectmock/10"))
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "Not Found")
            deleteExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}

extension SOAObjectTests {
    func mockedFetch() -> NetworkResponse {
        let data = "{\"id\":10}".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    func mockedFailedFetch() -> NetworkResponse {
        let userInfo = [NSLocalizedDescriptionKey:"Not Found"]
        let error = NSError(domain: "me.andregustavo.soa", code: 404, userInfo: userInfo)
        return NetworkResponse(httpCode: 404, result: nil, error: error)
    }
    
    func mockedSave() -> NetworkResponse {
        let data = "{\"id\":11}".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    func mockedFailedSave() -> NetworkResponse {
        let userInfo = [NSLocalizedDescriptionKey:"Unauthorized"]
        let error = NSError(domain: "me.andregustavo.soa", code: 401, userInfo: userInfo)
        return NetworkResponse(httpCode: 401, result: nil, error: error)
    }
    
    func mockedUpdate() -> NetworkResponse {
        let data = "{\"id\":10}".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    func mockedFailedUpdate() -> NetworkResponse {
        let userInfo = [NSLocalizedDescriptionKey:"Not Found"]
        let error = NSError(domain: "me.andregustavo.soa", code: 404, userInfo: userInfo)
        return NetworkResponse(httpCode: 404, result: nil, error: error)
    }
    
    func mockedDelete() -> NetworkResponse {
        let data = "{\"success\":true}".data(using: .utf8)
        return NetworkResponse(httpCode: 200, result: data, error: nil)
    }
    
    func mockedFailedDelete() -> NetworkResponse {
        let userInfo = [NSLocalizedDescriptionKey:"Not Found"]
        let error = NSError(domain: "me.andregustavo.soa", code: 404, userInfo: userInfo)
        return NetworkResponse(httpCode: 404, result: nil, error: error)
    }
}
