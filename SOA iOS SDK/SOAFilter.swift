//
//  SOAFilter.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct SOAFilter: CustomStringConvertible, Equatable {
    public let condition: SOAFilterCondition
    public let field: String
    public let value: String
    
    public var description: String {
        return "\(field):\(condition.rawValue):\(value)"
    }
}

public func ==(lhs: SOAFilter, rhs: SOAFilter) -> Bool {
    return lhs.condition == rhs.condition && lhs.field == rhs.field && lhs.value == rhs.value
}
