//
//  JSONConvertible.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public protocol JSONConvertible {
    var valueDictionary: JSONDictionary { get set }
    
    init?(dictionary: JSONDictionary)
}

public extension JSONConvertible {
    public func dictionary() -> JSONDictionary {
        return valueDictionary
    }
    
    public mutating func setValues(dictionary: JSONDictionary) {
        dictionary.forEach({self.valueDictionary[$0.key] = $0.value})
    }
}
