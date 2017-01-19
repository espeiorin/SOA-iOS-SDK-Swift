//
//  RequestProtocol.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public protocol Loadable {
    associatedtype EntityType
    
    var requestType: RequestType { get }
}

public extension Loadable {
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
        
        let restCompletion: NetworkCompletion = { response in
            guard let resultData = response.result else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let result = resource.handle(resultData)
            DispatchQueue.main.async {
                completion(result, response.error)
            }
        }
        
        switch resource.method {
        case .get:
            client.get(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            return
        case .post:
            if let files = resource.files {
                client.post(url: resourceURL, params: resource.data, files: files, headers: headers, completion: restCompletion)
                return
            }
            client.post(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            return
        case .put:
            client.put(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            return
        case .delete:
            client.delete(url: resourceURL, params: resource.data, headers: headers, completion: restCompletion)
            return
        }
    }
}
