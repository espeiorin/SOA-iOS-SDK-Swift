//
//  RemoteProcedureCall.swift
//  SOA iOS SDK
//
//  Created by Andre Espeiorin on 18/01/2017.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

public struct RemoteProcedureCall<T: JSONConvertible>: Loadable {
    public typealias EntityType = [T]
    
    public var requestType: RequestType
    public let procedure: String
    public var version: SOAVersion
    
    public init(procedure: String, version: SOAVersion = .unknown) {
        self.procedure = procedure
        self.requestType = .rpc
        self.version = version
    }
    
    public func execute(params: [String:Any]?, files: [String:UploadFile]?, completion: @escaping (EntityType?, Error?) -> Void) {
        
        var parameters = SOAParameters()
        if params != nil {
            parameters["parameters"] = params
        }
        
        let procedurePath = "\(version)/\(procedure)"
        
        let resource = Resource<EntityType>(method: .post, path: procedurePath, data: parameters, files: files, JSONHandle: { json in
            if let returnArray = json as? [[String:Any]] {
                return returnArray.flatMap({T(dictionary: $0)})
            }
            
            if let returnDictionary = json as? [String:Any], let object = T(dictionary: returnDictionary) {
                return [object]
            }
            
            return nil
        })
        
        load(resource: resource, completion: completion)
    }
    
    public func execute(params: [String:Any]?, completion: @escaping (EntityType?, Error?) -> Void) {
        execute(params: params, files: nil, completion: completion)
    }
}
