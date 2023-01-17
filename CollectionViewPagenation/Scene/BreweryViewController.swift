//
//  BreweryViewController.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BreweryViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(
            BreweryCollectionViewCell.self,
            forCellWithReuseIdentifier: BreweryCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private let viewModel: BreweryViewModelType = BreweryViewModel()
    private var disposeBag = DisposeBag()
    
    private var breweries: [BreweryModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.requestBrewery(page: currentPage, size: 25)
    }
}

extension BreweryViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]
    ) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach{
            if ($0.row + 1)/25 + 1 == currentPage {
                self.viewModel.inputs.requestBrewery(page: currentPage, size: 25)
            }
        }
    }
}


extension BreweryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return breweries.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BreweryCollectionViewCell.identifier,
            for: indexPath
        ) as? BreweryCollectionViewCell else { return UICollectionViewCell() }
        let brewery = breweries[indexPath.item]
        cell.setupCell(brewery: brewery)
        
        return cell
    }
}

extension BreweryViewController: UICollectionViewDelegateFlowLayout {
    
}

private extension BreweryViewController {
    func setupViews() {
        [
            collectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.breweriesPublishSubject
            .subscribe(onNext: { [weak self] breweries in
                guard let self = self else { return }
                self.breweries = breweries
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.currentPagePublishSubject
            .subscribe(onNext: { [weak self] currentPage in
                guard let self = self else { return }
                self.currentPage = currentPage
            })
            .disposed(by: disposeBag)
        
    }
}
