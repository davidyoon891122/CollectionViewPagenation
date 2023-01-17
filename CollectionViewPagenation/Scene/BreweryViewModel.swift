//
//  BreweryViewModel.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation
import RxSwift

protocol BreweryViewModelInput {
    func requestBrewery(page: Int, size: Int)
}

protocol BreweryViewModelOutput {
    var breweriesPublishSubject: PublishSubject<[BreweryModel]> { get }
    var currentPagePublishSubject: PublishSubject<Int> { get }
}

protocol BreweryViewModelType {
    var inputs: BreweryViewModelInput { get }
    var outputs: BreweryViewModelOutput { get }
}

final class BreweryViewModel: BreweryViewModelType, BreweryViewModelInput, BreweryViewModelOutput {
    var inputs: BreweryViewModelInput { self }
    var outputs: BreweryViewModelOutput { self }
    
    private let repository = BreweryRepository()
    private var disposeBag = DisposeBag()
    
    private var breweries: [BreweryModel] = []
    
    var breweriesPublishSubject: PublishSubject<[BreweryModel]> = .init()
    var currentPagePublishSubject: PublishSubject<Int> = .init()
    
    private var currentPage = 1
    
    func requestBrewery(page: Int, size: Int) {
        currentPage = page + 1
        
        currentPagePublishSubject.onNext(currentPage)
        
        repository.requestList(page: page, size: size)
            .subscribe(onNext: { [weak self] breweries in
                guard let self = self else { return }
                self.breweries += breweries
                self.outputs.breweriesPublishSubject.onNext(self.breweries)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
    }

    
}
