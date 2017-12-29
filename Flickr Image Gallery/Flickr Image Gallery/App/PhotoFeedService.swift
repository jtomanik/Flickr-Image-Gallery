//
//  PhotoFeedService.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 28/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation

struct PhotoFeedService {

    func getPublicFeed() -> [PhotoItem] {
        return generateMockData()
    }
}

extension PhotoFeedService {

    fileprivate func generateMockData() -> [PhotoItem] {
        guard let filePath = Bundle.main.path(forResource: "mock", ofType: ".json") else {
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
