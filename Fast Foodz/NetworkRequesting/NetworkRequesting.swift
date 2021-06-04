//
//  NetworkRequesting.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

public typealias ResponseResult<T> = Result<T, Error>

public protocol NetworkRequesting {
    func requestValue<ModelType: Decodable>(for endpoint: RestEndpoint, completion: @escaping (ResponseResult<ModelType>) -> Void)
}
