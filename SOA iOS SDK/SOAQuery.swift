//
//  SOAQuery.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 10/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct SOAQuery<T>: SOARequestProtocol where T:SOAObject {
    public typealias EntityType = SOAQueryResult<T>
    
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
        filters.append(filter)
    }
    
    mutating func remove(filter: SOAFilter) {
        filters.remove(filter)
    }
    
    mutating func clearFilters() {
        filters.removeAll()
    }
    
    mutating func append(join: SOAJoin) {
        joins.append(join)
    }
    
    mutating func remove(join: SOAJoin) {
        joins.remove(join)
    }
    
    mutating func clearJoins() {
        joins.removeAll()
    }
    
    func execute(completion: @escaping (EntityType?, Error?) -> Void) {
        
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
        
        let resource = Resource<EntityType>(method: .get, path: entity.lowercased(), data: params, JSONHandle: { json in
            guard let json = json as? [[String:Any]] else {
                return nil
            }
            
            return SOAQueryResult<T>(records: json.flatMap(self.jsonParse))
        })
        
        load(resource: resource, completion: completion)
    }
    
    fileprivate func jsonParse(input: [String:Any]) -> T? {
        var item = T(dictionary: input)
        item?.entity = self.entity
        return item
    }
}
