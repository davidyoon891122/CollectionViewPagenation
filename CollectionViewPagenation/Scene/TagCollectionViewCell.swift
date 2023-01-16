//
//  TagCollectionViewCell.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import UIKit
import SnapKit

final class TagCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8.0
        [
            titleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.trailing.equalToSuperview().offset(-8.0)
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = TagCollectionViewCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(
            width: UIView.layoutFittingCompressedSize.width,
            height: availableHeight
        )
        
        return cell.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
}

private extension TagCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
