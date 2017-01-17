//
//  JSONConvertible.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public protocol JSONConvertible {
    var valueDictionary: [String:Any] { get set }
    
    init?(dictionary: [String:Any])
    func dictionary() -> [String:Any]
    mutating func setValues(dictionary: [String:Any])
}

public extension JSONConvertible {
    public mutating func setValues(dictionary: [String:Any]) {
        dictionary.forEach({self.valueDictionary[$0.key] = $0.value})
    }
}
