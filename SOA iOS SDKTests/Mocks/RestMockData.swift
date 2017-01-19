//
//  RestMockData.swift
//  SOA iOS SDK
//
//  Created by Andre Gustavo on 11/01/17.
//  Copyright © 2017 Andre Gustavo. All rights reserved.
//

import Foundation

class RestMockData {
    var requestMethod: HTTPMethod?
    var requestURL: URL?
    var requestParams: [String:Any]?
    var requestFiles: [String:UploadFile]?
    var requestHeaders: [String:Any]?
}
