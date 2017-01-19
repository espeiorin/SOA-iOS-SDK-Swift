//
//  RESTClientProtocol.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (NetworkResponse) -> Void

public protocol NetworkClient {
    func get(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: NetworkCompletion)
    func post(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: NetworkCompletion)
    func post(url: URL, params: [String:Any]?, files: [String:UploadFile]?, headers: [String:Any?], completion: NetworkCompletion)
    func put(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: NetworkCompletion)
    func delete(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: NetworkCompletion)
}
