//
//  UIViewExtensions.swift
//  Fast Foodz
//
//  Created by Jordan on 5/28/21.
//

import UIKit

extension UIView {
    func addConstraints(_ constraintMaker: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraintMaker(self))
    }
}
