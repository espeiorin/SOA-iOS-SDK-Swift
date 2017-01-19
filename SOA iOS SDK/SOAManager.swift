//
//  SOAManager.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public class SOAManager {
    
    public static let shared: SOAManager = SOAManager()
    
    public var restClient: NetworkClient?
    public var restURL: URL?
    public var rpcURL: URL?
    public var sharedHeaders = [String:Any]()
    var headers = [HTTPMethod:[String:Any]]()
    
    public func set(headers: [String:Any], for method: HTTPMethod) {
        self.headers[method] = headers
    }
    
    public func headers(for method: HTTPMethod) -> [String:Any]? {
        return headers[method]
    }
    
}
