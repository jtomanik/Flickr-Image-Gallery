//
//  BackendPhotoFeeed.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

struct BackendPhotoFeed: Codable {

    let title: String
    let link: URL
    let description: String
    let modified: Date
    let generator: String
    let items: [BackendPhotoItem]
}
