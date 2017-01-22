//
//  RESTClientProtocol.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public protocol NetworkClient {
    func get(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping NetworkCompletion)
    func post(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping NetworkCompletion)
    func post(url: URL, params: SOAParameters?, files: SOAFiles?, headers: SOAHeaders?, completion: @escaping NetworkCompletion)
    func put(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping NetworkCompletion)
    func delete(url: URL, params: SOAParameters?, headers: SOAHeaders?, completion: @escaping NetworkCompletion)
}
