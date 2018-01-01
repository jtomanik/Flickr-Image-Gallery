//
//  PhotoFeedService.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 28/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

/// Abstraction to hide implementation details and prevent tight coupling between Presenter and DataSource
protocol PhotoFeedRepository {
    func getPublicFeed() -> Observable<[PhotoItem]>
}

struct PhotoFeedService: PhotoFeedRepository {

    func getPublicFeed() -> Observable<[PhotoItem]> {
        /// Current implementation mocks data source that provides two or more results for each request.
        /// First result comes from the cache and subsequent result(s) come from the backend.
        /// All work is performed on the backend queue.

        let cacheDelay = Int(arc4random_uniform(10)*100)
        let serverDelay = Int(arc4random_uniform(6)*1000)
        return Observable.create { observer in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(cacheDelay)) {
                observer.onNext(PhotoFeedMock.generateMockData(forResource: "mock"))
            }

            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(serverDelay)) {
                observer.onNext(PhotoFeedMock.generateMockData(forResource: "mock"))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

struct PhotoFeedMock {

    static func generateMockData(forResource resource: String) -> [PhotoItem] {
        guard let filePath = Bundle.main.path(forResource: resource, ofType: ".json") else {
            return []
        }

        let fileURL = URL(fileURLWithPath: filePath)

        guard let rawJson = try? Data.init(contentsOf: fileURL) else {
            return []
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let photoItems = try? decoder.decode([PhotoItem].self, from: rawJson) else {
            return []
        }

        return photoItems
    }
}
