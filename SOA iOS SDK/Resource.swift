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
    public let handle: (Data) -> T?
}

public extension Resource {
    public init(method: HTTPMethod, path: String, data: [String:Any]?, JSONHandle: @escaping (Any) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.handle = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json.flatMap(JSONHandle)
        }
    }
}
