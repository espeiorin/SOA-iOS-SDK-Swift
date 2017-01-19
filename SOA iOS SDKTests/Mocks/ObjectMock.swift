//
//  ObjectMock.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 16/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

struct ObjectMock: RemoteObject {
    public var requestType: RequestType = .rest

    typealias EntityType = ObjectMock
    
    var entity: String = ""
    var id: Int?
    var valueDictionary: [String : Any]
    
    init(entity: String) {
        self.entity = entity
        valueDictionary = [String:Any]()
    }
    
    init(entity: String, id: Int) {
        self.init(entity: entity)
        self.id = id
    }
    
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? Int else { return nil }
        self.id = id
        valueDictionary = dictionary
    }
    
    func dictionary() -> [String : Any] {
        return valueDictionary
    }
    
    mutating public func setValues(dictionary: [String : Any]) {
        valueDictionary = dictionary
    }
}
