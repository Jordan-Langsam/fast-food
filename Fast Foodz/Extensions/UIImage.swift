//
//  UIImage.swift
//  Fast Foodz
//
//  Created by Jordan on 6/2/21.
//

import Foundation
import UIKit

extension UIImage {
    static func load(with url: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        completion(image)
                }
            }
        }
    }
}
