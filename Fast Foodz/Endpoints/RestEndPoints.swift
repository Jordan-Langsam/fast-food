//
//  RestEndPoints.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

public enum RestMethod: String {
    case GET
}

public protocol RestEndpoint {
    var path: String { get }
    var method: RestMethod { get }
    var headers: [String : String]? { get }
}
