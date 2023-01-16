//
//  URLInfo.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation

enum URLInfo {
    case brewery
    
    var url: URL {
        switch self {
        case .brewery:
            return URL(string: "https://api.punkapi.com/v2/beers")!
        }
    }
}
