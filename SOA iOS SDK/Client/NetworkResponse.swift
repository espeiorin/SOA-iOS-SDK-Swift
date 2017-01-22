//
//  RESTResponse.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct NetworkResponse {
    public let httpCode: Int
    public var result: Data?
    public var error: Error?
    
    public init(httpCode: Int, result: Data?, error: Error?) {
        self.httpCode = httpCode
        self.result = result
        self.error = error
    }
}
