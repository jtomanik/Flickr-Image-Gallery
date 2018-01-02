//
//  PhotoFeedMock.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

struct PhotoFeedMock {

    static func generateMockData(forResource resource: String) -> [BackendPhotoItem] {
        guard let filePath = Bundle.main.path(forResource: resource, ofType: ".json") else {
            return []
        }

        let fileURL = URL(fileURLWithPath: filePath)

        guard let rawJson = try? Data.init(contentsOf: fileURL) else {
            return []
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let photoItems = try? decoder.decode([BackendPhotoItem].self, from: rawJson) else {
            return []
        }

        return photoItems
    }
}
