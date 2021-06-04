//
//  UITableView.swift
//  Fast Foodz
//
//  Created by Jordan on 5/30/21.
//

import Foundation
import UIKit

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
}
