//
//  PhotoItem.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

/// The Entity
/// Entities encapsulate Enterprise wide business rules.
/// An entity can be an object with methods, or it can be a set of data structures and functions.
struct PhotoItem {
    let id: String
    let title: String
    let link: URL
    let mediaURL: URL
    let dateTaken: Date
    let description: String
    let published: Date
    let author: Author
    let tags: [String]
}
