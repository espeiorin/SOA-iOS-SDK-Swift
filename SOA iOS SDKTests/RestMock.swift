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
    
    init(mockData: RestMockData) {
        self.mockData = mockData
    }
    
    func get(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .get
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
    }
    
    func post(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .post
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
    }
    
    func put(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .put
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
    }
    
    func delete(url: URL, params: [String : Any]?, headers: [String : Any]?, completion: (RESTResponse) -> Void) {
        mockData.requestMethod = .delete
        mockData.requestURL = url
        mockData.requestParams = params
        mockData.requestHeaders = headers
    }
}
