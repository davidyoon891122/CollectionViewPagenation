//
//  DetailImageCell.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/18.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailImageCell: UICollectionViewCell {
    static let identifier = "DetailImageCell"
    
    private lazy var breweryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        [
            breweryImageView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        breweryImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(300.0)
        }
        
        
        return view
    }()
    
    func setupCell(imageURL: String) {
        let url = URL(string: imageURL)
        breweryImageView.kf.setImage(with: url)
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

private extension DetailImageCell {
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
