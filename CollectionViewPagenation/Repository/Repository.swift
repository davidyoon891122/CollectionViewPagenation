//
//  Repository.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation
import RxSwift

final class Repository {
    
    private let service = BreweryService()
    private var disposeBag = DisposeBag()
    
    func requestBreweryList(page: Int, size: Int) {
        service.requestGet(
            url: URLInfo.brewery.url,
            responseType: [BreweryEntity].self,
            parameter: [
                "page": "\(page)",
                "size": "\(size)"
            ],
            header: [:]
        )
        .subscribe(onNext: { result in
            print(result)
        }, onError: { error in
            print("error: \(error.localizedDescription)")
        })
        .disposed(by: disposeBag)
    }
    
}
