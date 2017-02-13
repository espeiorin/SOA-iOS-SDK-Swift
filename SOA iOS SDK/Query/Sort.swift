//
//  Sort.swift
//  Pods
//
//  Created by Andre Gustavo on 22/01/17.
//
//

import Foundation

public func ==(lhs: Sort, rhs: Sort) -> Bool {
    return lhs.description == rhs.description
}

public struct Sort: Equatable {
    public let field: String
    public let sortBy: SortBy
    
    public init(field: String, by: SortBy) {
        self.field = field
        self.sortBy = by
    }
}

extension Sort: CustomStringConvertible {
    public var description: String {
        return "\(field):\(sortBy)"
    }
}
