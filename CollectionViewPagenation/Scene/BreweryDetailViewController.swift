//
//  BreweryDetailViewController.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class BreweryDetailViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = DynamicHeightFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            DetailImageCell.self,
            forCellWithReuseIdentifier: DetailImageCell.identifier
        )
        
        collectionView.register(
            DescriptionCell.self,
            forCellWithReuseIdentifier: DescriptionCell.identifier
        )
        
        collectionView.register(
            PairingCell.self,
            forCellWithReuseIdentifier: PairingCell.identifier
        )
        
        return collectionView
    }()
    
    private var brewery: BreweryModel
    
    init(brewery: BreweryModel) {
        self.brewery = brewery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension BreweryDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 2 {
            return brewery.foodPairing.count
        }
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailImageCell.identifier,
                for: indexPath
            ) as? DetailImageCell else { return UICollectionViewCell() }
            
            cell.setupCell(imageURL: brewery.imageURL)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DescriptionCell.identifier,
                for: indexPath
            ) as? DescriptionCell else { return UICollectionViewCell() }
            
            cell.setupCell(description: brewery.description)
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PairingCell.identifier,
                for: indexPath
            ) as? PairingCell else { return UICollectionViewCell() }

            let pair = brewery.foodPairing[indexPath.item]

            cell.setupCell(pair: pair)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension BreweryDetailViewController: UICollectionViewDelegateFlowLayout {

}

private extension BreweryDetailViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = brewery.name
    }
}
