//
//  Repository.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype T
    
    func requestList(page: Int, size: Int) -> Observable<T>
}



final class BreweryRepository: Repository {
    typealias T = [BreweryModel]
    
    private let service = BreweryService()
    private var disposeBag = DisposeBag()
    
    func requestList(page: Int, size: Int) -> Observable<[BreweryModel]>{
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            
            return self.service.requestGet(
                url: URLInfo.brewery.url,
                responseType: [BreweryEntity].self,
                parameter: [
                    "page": "\(page)",
                    "per_page": "\(size)"
                ],
                header: [:]
            )
            .subscribe(onNext: { result in
                var breweries: [BreweryModel] = []
                result.forEach {
                    let brewery = BreweryModel(
                        name: $0.name,
                        imageURL: $0.imageURL ?? "",
                        tagLines: $0.tagLines
                    )
                    breweries.append(brewery)
                }
                emitter.onNext(breweries)
                
            }, onError: { error in
                print("error: \(error.localizedDescription)")
                emitter.onError(error)
            })
        }
    }
}
