//
//  SOAObject.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 11/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

open class SOAObject {
    let entity: String
    var id: Int?
    var values = [String:Any]()
    
    public required init(entity: String) {
        self.entity = entity
    }
    
    public convenience init(entity: String, id: Int) {
        self.init(entity: entity)
        self.id = id
    }
    
    public class func retrieve(entity: String, id: Int, completion: @escaping (SOAObject?, Error?) -> Void) {
        
    }
    
    public class func save(entity: String, params: [String:Any], completion: @escaping (SOAObject?, Error?) -> Void) {
        
    }
    
    public class func delete(entity: String, id: Int, completion: @escaping (Error?) -> Void) {
        
    }
    
    public func fetch(completion: @escaping (SOAObject?, Error?) -> Void) {
        guard let id = id else {
            let error = NSError(domain: "me.andregustavo.soa", code: 0, userInfo: [NSLocalizedDescriptionKey:"Cannot fetch an entity without entity id"])
            completion(nil, error)
            return
        }
        
        
    }
    
    public func save(completion: @escaping (SOAObject?, Error?) -> Void) {
        
    }
    
    public func delete(completion: @escaping (Error?) -> Void) {
        guard let id = id else {
            let error = NSError(domain: "me.andregustavo.soa", code: 0, userInfo: [NSLocalizedDescriptionKey:"Cannot delete an entity without entity id"])
            completion(error)
            return
        }
        
    }
    
    public func setValues(from dictionary: [String:Any]) {
        
    }
}
