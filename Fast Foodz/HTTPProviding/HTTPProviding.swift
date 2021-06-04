//
//  HTTPProviding.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

protocol HTTPProviding {
    func task(request: URLRequest, completion: @escaping ((Data?, URLResponse?, Error?) -> Void))
}
