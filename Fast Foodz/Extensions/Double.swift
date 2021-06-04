//
//  Double.swift
//  Fast Foodz
//
//  Created by Jordan on 5/30/21.
//

import Foundation

private enum Constants {
    static let metersToMilesRatio: Double = 0.000621371
}

extension Double {
    func metersToMiles() -> Double {
        return self * Constants.metersToMilesRatio
    }
}
