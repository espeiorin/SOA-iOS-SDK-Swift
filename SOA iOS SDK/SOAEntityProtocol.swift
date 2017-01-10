//
//  SOARequestProtocol.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public enum SOARequestType {
    case rest
    case rpc
}

public protocol SOAEntityProtocol {
    associatedtype EntityType
    
    var requestType: SOARequestType { get }
}

public extension SOAEntityProtocol {
    public func load<EntityType>(resource: Resource<EntityType>, completion: @escaping (EntityType?, Error?) -> Void) {
        let manager = SOAManager.shared
        
        guard let client = manager.restClient else {
            print("SOA Rest Client not registered")
            abort()
        }
        
        guard let baseURL = requestType == .rest ? manager.restURL : manager.rpcURL else {
            print("SOA URL not registered")
            abort()
        }
        
        let resourceURL = baseURL.appendingPathComponent(resource.path)
        
        var headers = manager.sharedHeaders
        if let methodHeaders = manager.headers(for: resource.method) {
            headers.merge(with: methodHeaders)
        }
        
        let restCompletion: RESTClientCompletion = { response in
            guard let resultData = response.result else {
                return completion(nil, response.error)
            }
            completion(resource.handle(resultData), response.error)
        }
        
        switch resource.method {
        case .get:
            client.get(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            break
        case .post:
            client.post(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            break
        case .put:
            client.put(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            break
        case .delete:
            client.delete(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            break
        }
    }
}
