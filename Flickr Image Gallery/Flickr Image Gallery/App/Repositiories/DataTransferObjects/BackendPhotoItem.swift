//
//  BackendPhotoItem.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 28/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation

// swiftlint:disable variable_name
struct BackendPhotoItem: Codable {

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }

    struct MediaURL: Codable {
        let m: URL
    }

    let title: String
    let link: URL
    let media: MediaURL
    let dateTaken: Date
    let description: String
    let published: Date
    let author: String
    let authorId: String
    let tags: String
}
