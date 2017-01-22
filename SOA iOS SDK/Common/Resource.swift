//
//  Resource.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct Resource<T> {
    public let method: SOAHTTPMethod
    public let path: String
    public var data: SOAParameters?
    public var files: SOAFiles?
    public let handle: (Data) -> T?
    
    public init(method: SOAHTTPMethod, path: String, data: SOAParameters?, files: SOAFiles?, handle: @escaping (Data) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.files = files
        self.handle = handle
    }
    
    public init(method: SOAHTTPMethod, path: String, data: SOAParameters?, handle: @escaping (Data) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.files = nil
        self.handle = handle
    }
}
