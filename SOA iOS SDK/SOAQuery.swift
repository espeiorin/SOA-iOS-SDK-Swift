//
//  SOAQuery.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation
import SOA_SDK

public struct SOAQuery: SOAEntityProtocol {
    public typealias EntityType = SOAQueryResult
    
    public let requestType: SOARequestType = .rest
    
    public let entity: String
    public var fields: [String]?
    
    public var offset: Int?
    public var limit: Int?
    
    private var filters = [SOAFilter]()
    private var joins = [SOAJoin]()
    
    init(entity: String) {
        self.entity = entity
    }
    
    init(entity: String, fields: [String], offset: Int, limit: Int) {
        self.init(entity: entity)
        self.fields = fields
        self.offset = offset
        self.limit = limit
    }
    
    mutating func append(filter: SOAFilter) {
        
    }
    
    mutating func remove(filter: SOAFilter) {
        
    }
    
    mutating func clearFilters() {
        
    }
    
    mutating func append(join: SOAJoin) {
        
    }
    
    mutating func remove(join: SOAJoin) {
        
    }
    
    mutating func clearJoins() {
        
    }
    
    func execute(completion: (EntityType?, Error?) -> Void) {
        
        var params = [String:Any]()
        
        if let offset = offset {
            params["offset"] = offset
        }
        
        if let limit = limit {
            params["limit"] = limit
        }
        
        if let fields = fields {
            params["fields"] = fields.joined(separator: ",")
        }
        
        if filters.count > 0 {
            params["filters"] = filters.map({$0.description}).joined(separator: ",")
        }
        
        if joins.count > 0 {
            params["join"] = joins.map({$0.description}).joined(separator: ",")
        }
        
        let resource = Resource<SOAQueryResult>(method: .get, path: entity, data: params) { json in
            
            return nil
        }
        
        load(resource: resource, completion: completion)
    }
}
