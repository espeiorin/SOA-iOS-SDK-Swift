//
//  SortBy.swift
//  Pods
//
//  Created by Andre Gustavo on 22/01/17.
//
//

import Foundation

public enum SortBy {
    case asc
    case desc
}

extension SortBy: CustomStringConvertible {
    public var description: String {
        switch self {
        case .asc:
            return "asc"
        case .desc:
            return "desc"
        }
    }
}
