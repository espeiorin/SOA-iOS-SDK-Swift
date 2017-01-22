//
//  Resource+JSON.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 19/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public extension Resource {
    public init(method: SOAHTTPMethod, path: String, data: SOAParameters?, JSONHandle: @escaping (Any) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.handle = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json.flatMap(JSONHandle)
        }
        self.files = nil
    }
    
    public init(method: SOAHTTPMethod, path: String, data: SOAParameters?, files: SOAFiles?, JSONHandle: @escaping (Any) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.handle = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json.flatMap(JSONHandle)
        }
        self.files = files
    }
}
