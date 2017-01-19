//
//  FilterCondition.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public enum FilterCondition: String {
    case equal = "eq"
    case like = "like"
    case lowerThan = "lt"
    case lowerOrEqual = "lte"
    case greaterThan = "gt"
    case greaterOrEqual = "gte"
    case notEqual = "neq"
}
