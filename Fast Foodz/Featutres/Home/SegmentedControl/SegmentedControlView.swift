//
//  SegmentedControlView.swift
//  Fast Foodz
//
//  Created by Jordan on 5/28/21.
//

import UIKit

private struct Constants {
    static let ViewCornerRadius: CGFloat = 10.0
    static let ButtonCornerRadius: CGFloat = 8.0
}

class SegmentedControlView: UIView {
    
    private var segmentControl: UISegmentedControl
            
    init(option1Title: String, option2Title: String) {
        self.segmentControl = UISegmentedControl(items: [option1Title, option2Title])
        super.init(frame: CGRect.zero)
        setupBackground()
        setupSegmentController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
        backgroundColor = UIColor.londonSky
        layer.cornerRadius = Constants.ViewCornerRadius
    }
    
    private func setupSegmentController() {
        addSubview(segmentControl)
        
        segmentControl.selectedSegmentTintColor = UIColor.competitionPurple
        segmentControl.selectedSegmentIndex = SegmentedControlManager.shared.getMapIsSelected() ? 0 : 1
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.deepIndigo], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

        segmentControl.addConstraints{[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 2.0),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2.0),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2.0)
        ]}
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        SegmentedControlManager.shared.setMapIsSelected(isSelected: sender.selectedSegmentIndex == 0)
    }
    
    func setEnabed(enabled: Bool) {
        segmentControl.isEnabled = enabled
    }
}
