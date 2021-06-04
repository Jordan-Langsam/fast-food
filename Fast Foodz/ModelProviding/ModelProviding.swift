//
//  ModelProviding.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

public protocol ModelProviding {
    func serializeData<ModelType: Decodable>(data: Data) -> ModelType?
}
