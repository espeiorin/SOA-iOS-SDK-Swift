//
//  RestMock.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 11/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

struct RestMock: NetworkClient {
    
    var mockData: RestMockData
    var completionData = [SOAHTTPMethod:NetworkResponse]()
    
    init(mockData: RestMockData) {
        self.mockData = mockData
    }
    
    func get(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping (NetworkResponse) -> Void) {
        mockData.requestMethod = .get
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        mockData.requestFiles = nil
        
        if let response = completionData[.get] {
            return completion(response)
        }
        
        completion(NetworkResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func post(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping (NetworkResponse) -> Void) {
        mockData.requestMethod = .post
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        mockData.requestFiles = nil
        
        if let response = completionData[.post] {
            return completion(response)
        }
        
        completion(NetworkResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func post(url: URL, params: SOAParameters?, files: SOAFiles?, headers: SOAHeaders?, completion: @escaping NetworkCompletion) {
        mockData.requestMethod = .post
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        mockData.requestFiles = files
        
        if let response = completionData[.post] {
            return completion(response)
        }
        
        completion(NetworkResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func put(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping (NetworkResponse) -> Void) {
        mockData.requestMethod = .put
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        mockData.requestFiles = nil
        
        if let response = completionData[.put] {
            return completion(response)
        }
        
        completion(NetworkResponse(httpCode: 0, result: nil, error: nil))
    }
    
    func delete(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping (NetworkResponse) -> Void) {
        mockData.requestMethod = .delete
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
        mockData.requestFiles = nil
        
        if let response = completionData[.delete] {
            return completion(response)
        }
        
        completion(NetworkResponse(httpCode: 0, result: nil, error: nil))
    }
}
