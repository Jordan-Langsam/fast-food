//
//  URLRequestProvider.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

final class URLRequestProvider: URLRequestProviding {
    public func request(endpoint: RestEndpoint) -> URLRequest {
        let url = URL(string: endpoint.path)!
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        var request = URLRequest(url: urlComponents!.url!)
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpMethod = endpoint.method.rawValue
        return request
    }
}
