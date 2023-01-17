//
//  BreweryCollectionViewCell.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import UIKit
import SnapKit
import Kingfisher

final class BreweryCollectionViewCell: UICollectionViewCell {
    static let identifier = "BreweryCollectionViewCell"
    
    private lazy var breweryImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 30.0
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            TagCollectionViewCell.self,
            forCellWithReuseIdentifier: TagCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 8.0,
            bottom: 0,
            right: 8.0
        )
        
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
            $0.width.height.equalTo(60.0)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalTo(breweryImageView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(offset)
            $0.leading.equalTo(breweryImageView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    private var tags: [String] = ["Hello", "Korean", "iOS", "DynamicProgramming"] {
        didSet {
            tagCollectionView.reloadData()
        }
    }
    
    func setupCell(brewery: BreweryModel) {
        nameLabel.text = brewery.name
        tags = brewery.tagLines
        print("brewery name: \(brewery.name), tags: \(tags)")
        let url = URL(string: brewery.imageURL)
        breweryImageView.kf.setImage(with: url)
        setupViews()
    }
}

extension BreweryCollectionViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return tags.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCollectionViewCell.identifier,
            for: indexPath
        ) as? TagCollectionViewCell else { return UICollectionViewCell() }
        let tag = tags[indexPath.item]
        cell.setupCell(tag: tag)
        return cell
    }
}

extension BreweryCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let sizeLabel = UILabel()
        sizeLabel.font = .systemFont(ofSize: 14.0)
        sizeLabel.text = tags[indexPath.item]
        sizeLabel.sizeToFit()
        
        return CGSize(
            width: sizeLabel.frame.width + 16,
            height: 30.0
        )
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
