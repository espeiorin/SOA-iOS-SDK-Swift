//
//  RESTResponse.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct RESTResponse {
    let httpCode: Int
    var result: Data?
    var error: Error?
}
