//
//  SegmentedControlManager.swift
//  Fast Foodz
//
//  Created by Jordan on 5/31/21.
//

import Foundation

private enum Constants {
    static let mapIsSelectedKey = "mapIsSelectedKey"
}

class SegmentedControlManager {
    static let shared = SegmentedControlManager()
    private var mapIsSelected: Bool!
    
    init() {
        self.mapIsSelected = getMapIsSelected()
    }
    
    func getMapIsSelected() -> Bool {
        return UserDefaults.standard.value(forKey: Constants.mapIsSelectedKey) as? Bool ?? true
    }
    
    func setMapIsSelected(isSelected: Bool) {
        
        guard mapIsSelected == getMapIsSelected() else {
            return
        }
        
        mapIsSelected = !mapIsSelected
        
        UserDefaults.standard.setValue(isSelected, forKey: Constants.mapIsSelectedKey)
        NotificationCenter.default.post(name: Notification.Name.mapSelectedOptionDidChange, object: nil)
    }
}

extension Notification.Name {
    public static let mapSelectedOptionDidChange = Notification.Name(rawValue: "mapSelectedOptionDidChange")
}
