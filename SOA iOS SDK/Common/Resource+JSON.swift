//
//  Resource+JSON.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 19/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public extension Resource {
    public init(method: HTTPMethod, path: String, data: [String:Any]?, JSONHandle: @escaping (Any) -> T?) {
        self.method = method
        self.path = path
        self.data = data
        self.handle = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json.flatMap(JSONHandle)
        }
        self.files = nil
    }
    
    public init(method: HTTPMethod, path: String, data: [String:Any]?, files: [String:UploadFile]?, JSONHandle: @escaping (Any) -> T?) {
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
