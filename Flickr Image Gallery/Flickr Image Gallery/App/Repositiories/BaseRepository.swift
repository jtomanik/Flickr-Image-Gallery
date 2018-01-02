//
//  BaseRepository.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Cache

protocol NetworkProvider: class {
    func execute(request: URLRequest) -> Observable<Data>
}

class BaseRepository: NetworkProvider {

    enum NetworkingErrors: Error {
        case badURL
    }

    private lazy var memoryCache: MemoryConfig = {
        return MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
    }()
    private lazy var diskCache: DiskConfig = {
        return DiskConfig(name: "diskCache")
    }()
    private lazy var storage: Storage? = {
        return try? Storage(diskConfig: diskCache, memoryConfig: memoryCache)
    }()

    func execute(request: URLRequest) -> Observable<Data> {
        guard let url = request.url?.absoluteString else {
            return Observable.error(NetworkingErrors.badURL)
        }

        let networkStream = URLSession.shared.rx.data(request: request)
            .do(onNext: { [storage] data in
                storage?.async.setObject(data, forKey: url) {_ in }
            })

        let cacheStream: Observable<Data> = Observable.create { [storage] subscriber in
            guard let storage = storage else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            storage.async.object(ofType: Data.self, forKey: url) { (result) in
                switch result {
                case .value(let data):
                    subscriber.onNext(data)
                    subscriber.onCompleted()
                case .error:
                    subscriber.onCompleted()
                }
            }
            return Disposables.create()
        }

        return Observable.concat([cacheStream, networkStream])
    }
}
