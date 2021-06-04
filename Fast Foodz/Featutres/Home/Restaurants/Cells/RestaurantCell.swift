//
//  RestaurantCell.swift
//  Fast Foodz
//
//  Created by Jordan on 5/30/21.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    private let arrowImageView = UIImageView(image: RestaurantCellViewModelConstants.arrowImage)
    private let seperator = UIView()
    private let subheaderLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = RestaurantCellViewModelConstants.backgroundColor
        
        selectedBackgroundView = backgroundView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: RestaurantCellViewModel) {
        nameLabel.text = viewModel.getName
        iconImageView.image = viewModel.image
        subheaderLabel.attributedText = viewModel.attributedText()
        setupUI()
    }
    
    private func setupUI() {
        setupIconImageView()
        setupArrowImageView()
        setupNameLabel()
        setupSubheaderLabel()
        setupSeperator()
    }
    
    private func setupIconImageView() {
        iconImageView.tintColor = RestaurantCellViewModelConstants.arrowColor
        contentView.addSubview(iconImageView)
        
        iconImageView.addConstraints{[
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: RestaurantCellViewModelConstants.imageViewLeadingConstant),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: RestaurantCellViewModelConstants.topContentPadding),
            $0.widthAnchor.constraint(equalToConstant: RestaurantCellViewModelConstants.imageDimension),
            $0.heightAnchor.constraint(equalToConstant: RestaurantCellViewModelConstants.imageDimension)
        ]}
    }
    
    private func setupArrowImageView() {
        arrowImageView.tintColor = UIColor.deepIndigo
        contentView.addSubview(arrowImageView)
        
        arrowImageView.addConstraints{[
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -RestaurantCellViewModelConstants.arrowTrailingAnchor),
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            $0.widthAnchor.constraint(equalToConstant: arrowImageView.image?.size.width ?? 0)
        ]}
    }
    
    private func setupNameLabel() {
        nameLabel.numberOfLines = RestaurantCellViewModelConstants.nameLabelNumberOfLines
        nameLabel.font = RestaurantCellViewModelConstants.nameLabelFont
        nameLabel.textColor = RestaurantCellViewModelConstants.nameLabelTextColor
        contentView.addSubview(nameLabel)
        
        nameLabel.addConstraints{[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: RestaurantCellViewModelConstants.topContentPadding),
            $0.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: RestaurantCellViewModelConstants.labelLeadingAnchor),
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: RestaurantCellViewModelConstants.nameLabelWidthMultiplier)
        ]}
    }
    
    private func setupSubheaderLabel() {
        subheaderLabel.numberOfLines = RestaurantCellViewModelConstants.subheaderLabelNumberOfLines
        subheaderLabel.font = RestaurantCellViewModelConstants.subheaderLabelFont
        contentView.addSubview(subheaderLabel)
        
        subheaderLabel.addConstraints{[
            $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: RestaurantCellViewModelConstants.subheaderTopAnchor),
            $0.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ]}
    }
    
    private func setupSeperator() {
        seperator.backgroundColor = RestaurantCellViewModelConstants.seperatorViewColor
        contentView.addSubview(seperator)
        
        seperator.addConstraints{[
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -(RestaurantCellViewModelConstants.seperatorHorizontalPadding * 2)),
            $0.heightAnchor.constraint(equalToConstant: RestaurantCellViewModelConstants.seperatorHeight),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: RestaurantCellViewModelConstants.seperatorHorizontalPadding)
        ]}
    }
    
    func updateIconColor(yPosition: CGFloat, maxHeight: CGFloat) {
        let color = colorForPosition(position: yPosition, height: maxHeight)
        
        iconImageView.tintColor = color
        setNeedsLayout()
    }
    
    private func colorForPosition(position: CGFloat, height: CGFloat) -> UIColor {
        let gradientPortion: CGFloat = (height * ( CGFloat(1 / CGFloat(UIColor.gradientColors.count))))
                
        var color: UIColor?
        
        for index in 1...UIColor.gradientColors.count {
            if position <= gradientPortion * CGFloat(index) {
                color = UIColor.gradientColors[index - 1]
                break
            }
        }
        
        return color ?? UIColor.gradientColors.last!
    }
}
