//
//  SOAJoin.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct SOAJoin: CustomStringConvertible {
    let field: String
    let filter: SOAFilter
    public var description: String {
        return "\(field):\(filter)"
    }
}
