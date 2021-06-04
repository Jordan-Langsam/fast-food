//
//  Double.swift
//  Fast Foodz
//
//  Created by Jordan on 5/30/21.
//

import Foundation

private enum Constants {
    static let feetToMilesRatio: Double = 0.000189394
}

extension Double {
    func feetToMiles() -> Double {
        return self * Constants.feetToMilesRatio
    }
}
