//
//  PairingCollectionViewCell.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/18.
//

import UIKit
import SnapKit

final class PairingCell: UICollectionViewCell {
    static let identifier = "PairingCell"
    
    private lazy var pairingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        [
            pairingLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        pairingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    func setupCell(pair: String) {
        pairingLabel.text = pair
        setupViews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(
            width: layoutAttributes.frame.width,
            height: 0
        )
        
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return layoutAttributes
    }
}

private extension PairingCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
