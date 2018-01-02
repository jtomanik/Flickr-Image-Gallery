//
//  PhotoItem.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

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
