//
//  Filter.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct Filter: CustomStringConvertible, Equatable {
    public let condition: FilterCondition
    public let field: String
    public let value: String
    
    public var description: String {
        return "\(field):\(condition.rawValue):\(value)"
    }
}

public func ==(lhs: Filter, rhs: Filter) -> Bool {
    return lhs.condition == rhs.condition && lhs.field == rhs.field && lhs.value == rhs.value
}
