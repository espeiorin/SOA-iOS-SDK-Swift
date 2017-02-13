//
//  Query.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct Query<T: RemoteObject>: Loadable {
    public typealias EntityType = [T]
    
    public let requestType: RequestType = .rest
    
    public let entity: String
    public var fields: [String]?
    
    public var sort: Sort?
    public var offset: Int?
    public var limit: Int?
    
    private var filters = [Filter]()
    private var joins = [Join]()
    
    public init(entity: String) {
        self.entity = entity
    }
    
    public init(entity: String, fields: [String], offset: Int, limit: Int) {
        self.init(entity: entity)
        self.fields = fields
        self.offset = offset
        self.limit = limit
    }
    
    public mutating func append(filter: Filter) {
        filters.append(filter)
    }
    
    public mutating func remove(filter: Filter) {
        filters.remove(filter)
    }
    
    public mutating func clearFilters() {
        filters.removeAll()
    }
    
    public mutating func append(join: Join) {
        joins.append(join)
    }
    
    public mutating func remove(join: Join) {
        joins.remove(join)
    }
    
    public mutating func clearJoins() {
        joins.removeAll()
    }
    
    public func execute(completion: @escaping (EntityType?, Error?) -> Void) {
        
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
        
        if let sort = sort {
            params["sort"] = sort.description
        }
        
        let resource = Resource<EntityType>(method: .get, path: entity.lowercased(), data: params, JSONHandle: { json in
            guard let json = json as? [JSONDictionary] else {
                return nil
            }
            
            return json.flatMap(self.jsonParse)
        })
        
        load(resource: resource, completion: completion)
    }
    
    fileprivate func jsonParse(input: [String:Any]) -> T? {
        return T(dictionary: input)
    }
}
