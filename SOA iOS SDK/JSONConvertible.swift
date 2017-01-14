//
//  JSONConvertible.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public protocol JSONConvertible {
    init?(dictionary: [String:Any])
    func dictionary() -> [String:Any]
}
