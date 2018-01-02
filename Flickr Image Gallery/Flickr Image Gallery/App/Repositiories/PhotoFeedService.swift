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
    func getDetails(photoId: String) -> Observable<PhotoItem?>
    func getLargePhoto(for: PhotoItem) -> PhotoItem
}

final class PhotoFeedService: PhotoFeedRepository, PhotoDetailRepository {

    func getPublicFeed() -> Observable<[PhotoItem]> {
        /// Current implementation mocks data source that provides two or more results for each request.
        /// First result comes from the cache and subsequent result(s) come from the backend.
        /// All work is performed on the backend queue.

        let cacheDelay = Int(arc4random_uniform(10) * 100)
        let serverDelay = Int(arc4random_uniform(6) * 1000)
        return Observable.create { observer in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(cacheDelay)) {
                let mock = PhotoFeedMock.generateMockData(forResource: "photo_feeed_mock")
                let result = mock.map { $0.toDomainModel() }
                observer.onNext(result)
            }

            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(serverDelay)) {
                let mock = PhotoFeedMock.generateMockData(forResource: "photo_feeed_mock")
                let result = mock.map { $0.toDomainModel() }
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    func getDetails(photoId id: String) -> Observable<PhotoItem?> {
        return getPublicFeed()
            .map { $0.first(where: { $0.id == id }) }
    }

    func getLargePhoto(for photo: PhotoItem) -> PhotoItem {
        return getPhotoWithImage(ofSize: .medium800, for: photo)
    }

    private func getPhotoWithImage(ofSize size: FlickrImageSizes, for photo: PhotoItem) -> PhotoItem {
        return photo.getModelWithResizedImage(size: size)
    }
}

private enum FlickrImageSizes: String {
    //s    small square 75x75
    case smallSquare = "s"
    //q    large square 150x150
    case largeSquare = "q"
    //t    thumbnail, 100 on longest side
    case thumbnail = "t"
    //m    small, 240 on longest side
    case small240 = "m"
    //n    small, 320 on longest side
    case small320 = "n"
    //-    medium, 500 on longest side
    case medium500 = "-"
    //z    medium 640, 640 on longest side
    case medium640 = "z"
    //c    medium 800, 800 on longest side†
    case medium800 = "c"
    //b    large, 1024 on longest side*
    case large1024 = "b"
    //h    large 1600, 1600 on longest side†
    case large1600 = "h"
    //k    large 2048, 2048 on longest side†
    case large2048 = "k"
    // * Before May 25th 2010 large photos only exist for very large original images.
    // † Medium 800, large 1600, and large 2048 photos only exist after March 1st 2012.
}

extension BackendPhotoItem {

    func toDomainModel() -> PhotoItem {

        return PhotoItem(id: extractId(fromURL: link),
                         title: title,
                         link: link,
                         mediaURL: media.m,
                         dateTaken: dateTaken,
                         description: process(description: description),
                         published: published,
                         author: Author(id: authorId, name: extractAuthor(fromString: author)),
                         tags: extractTags(fromString: tags))
    }

    private func extractId(fromURL url: URL) -> String {
        return url.lastPathComponent
    }

    private func process(description: String) -> String {
        var result = description.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "")
        result = RegexImageReplacer.shared.replace(in: result)
        return result
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

extension PhotoItem {

    fileprivate func getModelWithResizedImage(size: FlickrImageSizes) -> PhotoItem {
        return PhotoItem(id: id,
            title: title,
            link: link,
            mediaURL: generateLargeURL(from: mediaURL, for: size),
            dateTaken: dateTaken,
            description: description,
            published: published,
            author: author,
            tags: tags)
    }

    /// based on https://www.flickr.com/services/api/misc.urls.html
    private func generateLargeURL(from url: URL, for size: FlickrImageSizes) -> URL {
        let lastComponent = url.lastPathComponent
        let baseURL = url.deletingLastPathComponent()
        var sections = lastComponent.components(separatedBy: "_")
        guard sections.count == 3 else {
            return url
        }
        var extensionComponents = sections[2].components(separatedBy: ".")
        guard extensionComponents.count == 2 else {
            return url
        }
        extensionComponents[0] = size.rawValue
        let newExtension = extensionComponents.joined(separator: ".")
        sections[2] = newExtension
        let newLastComponent = sections.joined(separator: "_")
        let newURL = baseURL.appendingPathComponent(newLastComponent)
        return newURL
    }
}

private final class RegexImageReplacer {

    static let shared = RegexImageReplacer()

    private let searchPattern = "<img.*?alt=\\\"(.*?)\" .*?>"
    private let replaceTemplate = "$1"

    private let regex: NSRegularExpression

    private init() {
        regex = try! NSRegularExpression(pattern: searchPattern, options: .caseInsensitive)
    }

    func replace(in input: String) -> String {
        let result = regex.stringByReplacingMatches(in: input,
                                              options: [],
                                              range: NSRange.init(location: 0, length: input.count),
                                              withTemplate: replaceTemplate)
        return result
    }
}
