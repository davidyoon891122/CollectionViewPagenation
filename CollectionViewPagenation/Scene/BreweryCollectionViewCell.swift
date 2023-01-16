//
//  BreweryCollectionViewCell.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import UIKit
import SnapKit

final class BreweryCollectionViewCell: UICollectionViewCell {
    static let identifier = "BreweryCollectionViewCell"
    
    private lazy var breweryImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 40.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 12.0)
        
        return label
    }()
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            breweryImageView,
            nameLabel,
            tagCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
        breweryImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(offset)
            $0.width.height.equalTo(80.0)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalTo(breweryImageView.snp.trailing).offset(offset)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(offset)
            $0.leading.equalTo(breweryImageView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
}

private extension BreweryCollectionViewCell {
    func setupViews() {
        backgroundColor = .secondarySystemBackground
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
