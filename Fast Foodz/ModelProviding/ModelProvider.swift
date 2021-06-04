//
//  ModelProvider.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

final class ModelProvider: ModelProviding {
    public func serializeData<ModelType: Decodable>(data: Data) -> ModelType? {
        do {
            let result = try JSONDecoder().decode(ModelType.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}
