//
//  PhotoDetailTest.swift
//  Flickr Image GalleryTests
//
//  Created by Jakub Tomanik on 03/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import Flickr_Image_Gallery

// swiftlint:disable type_name
class PhotoDetailTest: XCTestCase {

    private var connector: MockPhotoFeedConnector!
    private var network: MockReactiveNetworkGateway!
    private var gateway: PhotoFeedRepository!
    private var useCase: UseCaseFacade!
    private var presenter: PhotoDetailPresenter!
    private var testScheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()

        testScheduler = TestScheduler(initialClock: 0, resolution: resolution, simulateProcessingDelay: false)
        connector = MockPhotoFeedConnector()
        network = try! MockReactiveNetworkGateway(scheduler: testScheduler, mockFilename: "photo_feeed_mock")
        gateway = PhotoFeedRepository(networkProvider: network)
        let gateways = UseCaseFacade.Gateways(photoFeed: gateway)
        useCase = UseCaseFacade(gateways: gateways)
        presenter = PhotoDetailPresenter(interactor: useCase, navigator: connector)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

        testScheduler = nil
        connector = nil
        network = nil
        gateway = nil
        presenter = nil
        disposeBag = nil
    }

    func testPhotoDetailUseCase() {
        let exampleItem = gateway.expected[0]
        let result = useCase.getLargePhoto(for: exampleItem)
        let sizeMark = ImageSizes.medium800.rawValue
        let lastURLComponent = result.mediaURL.lastPathComponent
        let hasSizeMark = lastURLComponent.contains(sizeMark)
        XCTAssert(hasSizeMark)
    }

    func testPhotoDetailPresenter() {
        let exampleItem = gateway.expected[0]
        presenter.inject(model: exampleItem)
        presenter.configure()
        let title = presenter.getPhotoTitle()
        XCTAssertEqual(title, exampleItem.title)
    }
}
