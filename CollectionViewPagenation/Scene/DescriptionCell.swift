//
//  DescriptionCell.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/18.
//

import UIKit
import SnapKit

final class DescriptionCell: UICollectionViewCell {
    static let identifier = "DescriptionCell"
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        [
            descriptionLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    func setupCell(description: String) {
        descriptionLabel.text = description
        setupViews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return layoutAttributes
    }
}

private extension DescriptionCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10.0)
        }
    }
}
