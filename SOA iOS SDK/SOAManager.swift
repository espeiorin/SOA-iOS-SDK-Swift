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
    public var imageURL: URL?
    public var sharedHeaders = SOAHeaders()
    var headers = [SOAHTTPMethod:SOAHeaders]()
    
    public func set(headers: SOAHeaders, for method: SOAHTTPMethod) {
        self.headers[method] = headers
    }
    
    public func headers(for method: SOAHTTPMethod) -> SOAHeaders? {
        return headers[method]
    }
    
}
