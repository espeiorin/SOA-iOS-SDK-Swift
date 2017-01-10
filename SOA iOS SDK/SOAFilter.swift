//
//  SOAFilter.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct SOAFilter: CustomStringConvertible {
    public let condition: SOAFilterCondition
    public let field: String
    public let value: Any
    
    public var description: String {
        return "\(field):\(condition.rawValue):\(value)"
    }
}
