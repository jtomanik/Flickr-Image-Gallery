//
//  PhotoFeedService.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 28/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseRepository: class {}

/// Abstraction to hide implementation details and prevent tight coupling between Presenter and DataSource
protocol PhotoFeedRepository: BaseRepository {
    func getPublicFeed() -> Observable<[PhotoItem]>
}

protocol PhotoDetailRepository: BaseRepository {
    func getDetails(photoId: String) -> Observable<PhotoItem>
}

final class PhotoFeedService: PhotoFeedRepository {

    func getPublicFeed() -> Observable<[PhotoItem]> {
        /// Current implementation mocks data source that provides two or more results for each request.
        /// First result comes from the cache and subsequent result(s) come from the backend.
        /// All work is performed on the backend queue.

        let cacheDelay = Int(arc4random_uniform(10) * 100)
        let serverDelay = Int(arc4random_uniform(6) * 1000)
        return Observable.create { observer in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(cacheDelay)) {
                let mock = PhotoFeedMock.generateMockData(forResource: "mock")
                let result = mock.map { $0.toDomainModel() }
                observer.onNext(result)
            }

            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(serverDelay)) {
                let mock = PhotoFeedMock.generateMockData(forResource: "mock")
                let result = mock.map { $0.toDomainModel() }
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

fileprivate extension BackendPhotoItem {

    func toDomainModel() -> PhotoItem {

        return PhotoItem(id: extractId(fromURL: link),
                         title: title,
                         link: link,
                         mediaURL: media.m,
                         dateTaken: dateTaken,
                         description: description,
                         published: published,
                         author: Author(id: authorId, name: extractAuthor(fromString: author)),
                         tags: extractTags(fromString: tags))
    }

    private func extractId(fromURL url: URL) -> String {
        return url.lastPathComponent
    }

    private func extractTags(fromString raw: String) -> [String] {
        let components = raw.components(separatedBy: " ")
        guard
            !components.isEmpty,
            components[0] != ""
        else {
            return []
        }
        return components
    }

    private func extractAuthor(fromString raw: String) -> String {
        let components = raw.components(separatedBy: "\"")
        guard components.count == 3 else {
            return ""
        }
        return components[1]
    }
 }
