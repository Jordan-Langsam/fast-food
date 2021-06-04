//
//  HTTPProvider.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

final class HTTPProvider: HTTPProviding {
    private let session: URLSession
    private var dataTask: URLSessionDataTask?
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func task(request: URLRequest, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        dataTask = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        dataTask?.resume()
    }
}
