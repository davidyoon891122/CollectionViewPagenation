//
//  BreweryService.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation
import RxSwift
import Alamofire

final class BreweryService {
    func requestGet<T: Decodable>(
        url: URL,
        responseType: T.Type,
        parameter: [String: Any],
        header: HTTPHeaders
    ) -> Observable<T> {
        return Observable.create { emitter in
            AF.request(
                url,
                method: .get,
                parameters: parameter,
                headers: header
            )
            .responseData { response in
                guard let status = response.response?.statusCode,
                      let data = response.value
                else {
                    emitter.onError(NetworkError.responseError)
                    return
                }
                
                switch status {
                case 200..<300:
                    // JSON 처리
                    guard let jsonModel = try? JSONDecoder().decode(T.self, from: data) else {
                        print(NetworkError.decodingError.rawValue)
                        emitter.onError(NetworkError.decodingError)
                        return
                    }
                    emitter.onNext(jsonModel)
                default:
                    print(NetworkError.responseError.rawValue)
                    emitter.onError(NetworkError.responseError)
                }
            }
            return Disposables.create()
        }
    }
}

enum NetworkError: String, Error {
    case responseError = "Server Response Error"
    case decodingError = "JSON Decoding Error"
}
