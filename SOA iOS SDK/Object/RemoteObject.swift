//
//  Object.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public protocol RemoteObject: JSONConvertible, Loadable {
    typealias EntityType = Self
    
    var entity: String { get set }
    var id: Int? { get set }
    
    init(entity: String)
    init(entity: String, id: Int)
}

public extension RemoteObject {
    public static func retrieve(entity: String, id: Int, completion: @escaping (Self?, Error?) -> Void) {
        var object = Self(entity: entity, id: id)
        object.fetch(completion: completion)
    }
    
    public static func save(entity: String, id: Int?, data: [String:Any], completion: @escaping (Self?, Error?) -> Void) {
        var object = Self(entity: entity)
        object.id = id
        object.setValues(dictionary: data)
        object.save(completion: completion)
    }
    
    public static func delete(entity: String, id: Int, completion: @escaping (Error?) -> Void) {
        var object = Self(entity: entity, id: id)
        object.delete(completion: completion)
    }
    
    public mutating func fetch(completion: @escaping (Self?, Error?) -> Void) {
        guard let _ = id else {
            let error = NSError(domain: "me.andregustavo.soa", code: 0, userInfo: [NSLocalizedDescriptionKey:"Cannot fetch an entity without entity id"])
            completion(nil, error)
            return
        }
        load(resource: fetchResource, completion: completion)
    }
    
    public mutating func save(completion: @escaping (Self?, Error?) -> Void) {
        let resource = (id == nil) ? newResource : updateResource
        load(resource: resource, completion: completion)
    }
    
    public mutating func delete(completion: @escaping (Error?) -> Void) {
        guard let _ = id else {
            let error = NSError(domain: "me.andregustavo.soa", code: 0, userInfo: [NSLocalizedDescriptionKey:"Cannot delete an entity without entity id"])
            completion(error)
            return
        }
        
        load(resource: deleteResource) { result, error in
            completion(error)
        }
    }
}

fileprivate extension RemoteObject {
    var newResource: Resource<Self> {
        return Resource<Self>(method: .post, path: self.entity.lowercased(), data: valueDictionary, JSONHandle: { json in
            guard let json = json as? [String:Any] else { return nil }
            var object = self
            if let id = json["id"] as? Int {
                object.id = id
            }
            object.setValues(dictionary: json)
            return object
        })
    }
    
    var updateResource: Resource<Self> {
        return Resource<Self>(method: .put, path: "\(self.entity.lowercased())/\(id ?? 0)", data: valueDictionary, JSONHandle: { json in
            guard let json = json as? [String:Any] else { return nil }
            var object = self
            object.setValues(dictionary: json)
            return object
        })
    }
    
    var fetchResource: Resource<Self> {
        return Resource<Self>(method: .get, path: "\(self.entity.lowercased())/\(id ?? 0)", data: nil, JSONHandle: { json in
            guard let json = json as? [String:Any] else { return nil }
            var object = self
            object.setValues(dictionary: json)
            return object
        })
    }
    
    var deleteResource: Resource<Self> {
        return Resource<Self>(method: .delete, path: "\(self.entity.lowercased())/\(id ?? 0)", data: nil, JSONHandle: { json in
            return nil
        })
    }
}
