//
//  NetworkRequester.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

public enum ResponseError: Error {
    case invalidData
    case network
}

public final class NetworkRequester: NetworkRequesting {
    private let modelProviding: ModelProviding
    private let httpProviding: HTTPProviding
    private let urlRequestProviding: URLRequestProviding
    
    init(modelProviding: ModelProviding,
         httpProviding: HTTPProviding,
         urlRequestProviding: URLRequestProviding) {
        self.modelProviding = modelProviding
        self.httpProviding = httpProviding
        self.urlRequestProviding = urlRequestProviding
    }
    
    public func requestValue<ModelType: Decodable>(for endpoint: RestEndpoint, completion: @escaping (ResponseResult<ModelType>) -> Void) {
        let urlRequest = urlRequestProviding.request(endpoint: endpoint)
        httpProviding.task(request: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(ResponseError.network))
                return
            }

            guard let model: ModelType = self?.modelProviding.serializeData(data: data) else {
                completion(.failure(ResponseError.invalidData))
                return
            }

            completion(.success(model))
        }
    }
}
