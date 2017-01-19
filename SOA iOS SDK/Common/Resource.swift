//
//  Resource.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct Resource<T> {
    public let method: HTTPMethod
    public let path: String
    public var data: [String:Any]?
    public var files: [String:UploadFile]?
    public let handle: (Data) -> T?
    
    public init(method: HTTPMethod, path: String, data: [String:Any]?, files: [String:UploadFile]?, handle: @escaping (Data) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.files = files
        self.handle = handle
    }
    
    public init(method: HTTPMethod, path: String, data: [String:Any]?, handle: @escaping (Data) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.files = nil
        self.handle = handle
    }
}
