//
//  RestMock.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 11/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

struct RestMock: RESTClientProtocol {
    
    var mockData: RestMockData
    var completionData = [HTTPMethod:RESTResponse]()
    
    init(mockData: RestMockData) {
        self.mockData = mockData
    }
    
    func get(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .get
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        
        if let response = completionData[.get] {
            return completion(response)
        }
        
        completion(RESTResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func post(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .post
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        
        if let response = completionData[.post] {
            return completion(response)
        }
        
        completion(RESTResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func put(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .put
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        
        if let response = completionData[.put] {
            return completion(response)
        }
        
        completion(RESTResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func delete(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .delete
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        
        if let response = completionData[.delete] {
            return completion(response)
        }
        
        completion(RESTResponse(httpCode: 0, result: nil, error: nil))
    }
}
