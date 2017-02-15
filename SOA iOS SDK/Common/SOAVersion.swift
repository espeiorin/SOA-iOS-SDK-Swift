//
//  SOAVersion.swift
//  Pods
//
//  Created by Andre Gustavo on 15/02/17.
//
//

import Foundation

public struct SOAVersion: RawRepresentable {
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let unknown: SOAVersion = SOAVersion(rawValue: "")
}
