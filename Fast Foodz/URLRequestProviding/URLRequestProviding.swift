//
//  URLRequestProviding.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

protocol URLRequestProviding {
    func request(endpoint: RestEndpoint) -> URLRequest
}
