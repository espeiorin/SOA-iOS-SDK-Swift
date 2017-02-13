//
//  Join.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct Join: CustomStringConvertible, Equatable {
    public let field: String
    public let filter: Filter
    public var description: String {
        return "\(field):\(filter)"
    }
    
    public init(field: String, filter: Filter) {
        self.field = field
        self.filter = filter
    }
}

public func ==(lhs: Join, rhs: Join) -> Bool {
    return lhs.field == rhs.field && lhs.filter == rhs.filter
}
