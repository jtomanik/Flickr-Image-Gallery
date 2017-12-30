//
//  PhotoFeedTest.swift
//  Flickr Image GalleryTests
//
//  Created by Jakub Tomanik on 30/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import Flickr_Image_Gallery

let resolution: TimeInterval = 0.2 // seconds

// swiftlint:disable type_name
class PhotoFeedTest: XCTestCase {

    private var repository: MockPhotoFeedService!
    private var presenter: PhotoFeedPresenter!
    private var testScheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        
        testScheduler = TestScheduler(initialClock: 0, resolution: resolution, simulateProcessingDelay: false)
        repository = MockPhotoFeedService(scheduler: testScheduler)
        presenter = PhotoFeedPresenter(repository: repository)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

        testScheduler = nil
        repository = nil
        presenter = nil
    }

    func testPresenterItemCount() {
        SharingScheduler.mock(scheduler: testScheduler) {
            presenter.configure()
            let recording = testScheduler.record(source: presenter.items)

            testScheduler.start()

            guard
                let last = recording.events.last,
                let value = last.value.element
                else {
                    XCTFail()
                    return
            }
            XCTAssertEqual(repository.expectedData.count, value)
        }
    }

    func testPresenterReloadCount() {
        SharingScheduler.mock(scheduler: testScheduler) {
            presenter.configure()
            let recording = testScheduler.record(source: presenter.items)

            testScheduler.start()
            XCTAssertEqual(recording.events.count, repository.invocationCount+1)
        }
    }

}

private final class MockPhotoFeedService: PhotoFeedRepository {

    let expectedData = PhotoFeedMock.generateMockData(forResource: "mock")
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
