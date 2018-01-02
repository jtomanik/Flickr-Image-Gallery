//
//  PhotoFeedGate.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

/// The Repositiory
/// A Repository mediates between the data source and the business domain of the application.
/// It queries the data source for the data, maps the data from the data source to a business entity, and persists changes in the business entity to the data source.
/// A repository separates the business logic contained in the Use Cases from the interactions with the underlying data source or Web service.
/// Repositories are concrete implementations of gateways (boundaries).
final class PhotoFeedRepository: PhotoFeedGateway {

    private let networkQuery: NetworkProvider
    private let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    init(networkProvider: NetworkProvider) {
        networkQuery = networkProvider
    }

    func getPublicFeed() -> Observable<[PhotoItem]> {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
        return networkQuery.execute(request: request)
            .map { try self.parse(data: $0) }
    }

    private func parse(data: Data) throws -> [PhotoItem] {
        let feed = try decoder.decode(BackendPhotoFeed.self, from: data)
        let items = feed.items.map { $0.toDomainModel() }
        return items
    }
}

fileprivate extension BackendPhotoItem {

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
