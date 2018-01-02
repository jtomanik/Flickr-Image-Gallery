//
//  ScaledPhotoGateway.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

final class ScaledPhotoGateway: ScaledPhotoRepository {

    func getLargePhoto(for photo: PhotoItem) -> PhotoItem {
        return getPhotoWithImage(ofSize: .medium800, for: photo)
    }

    private func getPhotoWithImage(ofSize size: ImageSizes, for photo: PhotoItem) -> PhotoItem {
        return photo.getModelWithResizedImage(size: size)
    }
}

fileprivate extension PhotoItem {

    fileprivate func getModelWithResizedImage(size: ImageSizes) -> PhotoItem {
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
    private func generateLargeURL(from url: URL, for size: ImageSizes) -> URL {
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
