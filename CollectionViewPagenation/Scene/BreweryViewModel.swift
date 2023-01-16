//
//  BreweryViewModel.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation

protocol BreweryViewModelInput {
    func requestBrewery(page: Int, size: Int)
}

protocol BreweryViewModelOutput {
    
}

protocol BreweryViewModelType {
    var inputs: BreweryViewModelInput { get }
    var outputs: BreweryViewModelOutput { get }
}

final class BreweryViewModel: BreweryViewModelType, BreweryViewModelInput, BreweryViewModelOutput {
    var inputs: BreweryViewModelInput { self }
    var outputs: BreweryViewModelOutput { self }
    
    private let repository = Repository()
    
    func requestBrewery(page: Int, size: Int) {
        repository.requestBreweryList(page: page, size: size)
        
    }

    
}
