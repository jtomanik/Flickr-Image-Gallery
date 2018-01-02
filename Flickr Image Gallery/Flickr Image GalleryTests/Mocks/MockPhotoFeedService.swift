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

final class MockPhotoFeedService: PhotoFeedRepository {

    let expectedData: [PhotoItem] = {
        let mock = PhotoFeedMock.generateMockData(forResource: "photo_feeed_mock")
        let result = mock.map { $0.toDomainModel() }
        return result
    }()
    let invocationCount = 2

    private let scheduler: TestScheduler
    private lazy var events: [String: [PhotoItem]] = ["e": self.expectedData]

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    func getPublicFeed() -> Observable<[PhotoItem]> {
        return scheduler.mock(values: events) {
            return "-e------e-|"
        }
    }
}
