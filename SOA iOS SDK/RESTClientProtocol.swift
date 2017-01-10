//
//  RESTClientProtocol.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public typealias RESTClientCompletion = (RESTResponse) -> Void

public protocol RESTClientProtocol {
    func get(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: RESTClientCompletion)
    func post(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: RESTClientCompletion)
    func put(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: RESTClientCompletion)
    func delete(url: URL, params: [String:Any]?, headers: [String:Any]?, completion: RESTClientCompletion)
}
