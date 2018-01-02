//
//  MockPhotoFeedService.swift
//  Flickr Image GalleryTests
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import Flickr_Image_Gallery

final class MockReactiveNetworkGateway: NetworkProvider, InvocationCountable, ResultsExpectable {

    enum MockNetworkErrors: Error {
        case mockFileNotFound
    }

    let invocationCount = 2
    lazy var expected: Data = {
        return try! self.generateMockData(forResource: self.filename)
    }()

    private let scheduler: TestScheduler
    private lazy var events: [String: Data] = ["e": self.expected]
    /// filename without the extension
    private let filename: String

    init(scheduler: TestScheduler, mockFilename: String) throws {
        self.scheduler = scheduler
        self.filename = mockFilename

        guard let _ = Bundle.main.path(forResource: mockFilename, ofType: ".json") else {
            throw MockNetworkErrors.mockFileNotFound
        }
    }

    func execute(request: URLRequest) -> Observable<Data> {
        return scheduler.mock(values: events) {
            return "-e------e-|"
        }
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
