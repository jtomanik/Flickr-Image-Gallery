//
//  PhotoFeedMock.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

final class MockNetworkGateway: NetworkProvider {

    enum MockNetworkErrors: Error {
        case mockFileNotFound
    }

    /// filename without the extension
    private let filename: String

    init(mockFilename: String) {
        filename = mockFilename
    }

    func execute(request: URLRequest) -> Observable<Data> {
        return Observable.just(filename)
            .map { try self.generateMockData(forResource: $0) }
    }

    private func generateMockData(forResource resource: String) throws -> Data {
        guard let filePath = Bundle.main.path(forResource: resource, ofType: ".json") else {
            throw MockNetworkErrors.mockFileNotFound
        }

        let fileURL = URL(fileURLWithPath: filePath)
        let data = try Data.init(contentsOf: fileURL)
        return data
    }
}
