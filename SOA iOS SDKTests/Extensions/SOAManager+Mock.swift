//
//  SOAManager.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 11/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

extension SOAManager {
    func tearDown() {
        restClient = nil
        restURL = nil
        rpcURL = nil
        sharedHeaders.removeAll()
        headers.removeAll()
    }
}
