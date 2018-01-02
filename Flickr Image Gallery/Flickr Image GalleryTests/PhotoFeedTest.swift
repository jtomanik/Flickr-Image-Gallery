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

    private var connector: MockPhotoFeedConnector!
    private var network: NetworkProvider!
    private var gateway: PhotoFeedGateway!
    private var useCase: UseCaseFacade!
    private var presenter: PhotoFeedPresenter!
    private var testScheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        
        testScheduler = TestScheduler(initialClock: 0, resolution: resolution, simulateProcessingDelay: false)
        connector = MockPhotoFeedConnector()
        network = try! MockReactiveNetworkGateway(scheduler: testScheduler, mockFilename: "photo_feeed_mock")
        gateway = PhotoFeedRepository(networkProvider: network)
        let gateways = UseCaseFacade.Gateways(photoFeed: gateway)
        useCase = UseCaseFacade(gateways: gateways)
        presenter = PhotoFeedPresenter(interactor: useCase, navigator: connector)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

        testScheduler = nil
        connector = nil
        network = nil
        gateway = nil
        presenter = nil
    }

    func testPresenterItemCount() {
        SharingScheduler.mock(scheduler: testScheduler) {
            presenter.configure()
            let recording = testScheduler.record(source: presenter.items)

            testScheduler.start()

            guard
                let gateway = gateway as? PhotoFeedRepository,
                let last = recording.events.last,
                let value = last.value.element
            else {
                    XCTFail()
                    return
            }
            XCTAssertEqual(gateway.expected.count, value)
        }
    }

    func testPresenterReloadCount() {
        SharingScheduler.mock(scheduler: testScheduler) {
            presenter.configure()
            let recording = testScheduler.record(source: presenter.items)

            testScheduler.start()

            guard let gateway = network as? MockReactiveNetworkGateway else {
                XCTFail()
                return
            }
            XCTAssertEqual(recording.events.count, gateway.invocationCount+1)
        }
    }

}

extension PhotoFeedRepository: ResultsExpectable {

    var expected: [PhotoItem] {
        let data: [PhotoItem] = [
            PhotoItem(id: "24578822067",
                      title: "imsi20180102040331",
                      link: URL(string: "https://www.flickr.com/photos/158945054@N02/24578822067/")!,
                      mediaURL: URL(string: "https://farm5.staticflickr.com/4600/24578822067_356ce51e6e_m.jpg")!,
                      dateTaken: ISODateFormatter.shared.date(from: "2018-01-01T23:03:34-08:00")!,
                      description: " <a href=\"https://www.flickr.com/people/158945054@N02/\">prayforruin</a> posted a photo: <a href=\"https://www.flickr.com/photos/158945054@N02/24578822067/\" title=\"imsi20180102040331\">imsi20180102040331</a> ",
                      published: ISODateFormatter.shared.date(from: "2018-01-02T07:03:34Z")!,
                      author: Author(id: "158945054@N02", name: "prayforruin"),
                      tags: []),
            PhotoItem(id: "24578823297",
                      title: "26055815_864347597023069_6101914283144738102_n.jpg",
                      link: URL(string: "https://www.flickr.com/photos/40129895@N03/24578823297/")!,
                      mediaURL: URL(string: "https://farm5.staticflickr.com/4679/24578823297_a5b3d3fcca_m.jpg")!,
                      dateTaken: ISODateFormatter.shared.date(from: "2018-01-01T23:03:39-08:00")!,
                      description: " <a href=\"https://www.flickr.com/people/40129895@N03/\">nhadatvideo</a> posted a photo: <a href=\"https://www.flickr.com/photos/40129895@N03/24578823297/\" title=\"26055815_864347597023069_6101914283144738102_n.jpg\">26055815_864347597023069_6101914283144738102_n.jpg</a> ",
                      published: ISODateFormatter.shared.date(from: "2018-01-02T07:03:39Z")!,
                      author: Author(id: "40129895@N03", name: "nhadatvideo"),
                      tags: ["nhadatvideo"]),
            PhotoItem(id: "25575160548",
                      title: "20171230-33-Taste of Tasmania randoms",
                      link: URL(string: "https://www.flickr.com/photos/rogertwong/25575160548/")!,
                      mediaURL: URL(string: "https://farm5.staticflickr.com/4640/25575160548_b7355ab9c0_m.jpg")!,
                      dateTaken: ISODateFormatter.shared.date(from: "2017-12-30T18:42:25-08:00")!,
                      description: " <a href=\"https://www.flickr.com/people/rogertwong/\">Roger T Wong</a> posted a photo: <a href=\"https://www.flickr.com/photos/rogertwong/25575160548/\" title=\"20171230-33-Taste of Tasmania randoms\">20171230-33-Taste of Tasmania randoms</a> ",
                      published: ISODateFormatter.shared.date(from: "2018-01-02T07:03:37Z")!,
                      author: Author(id: "14220155@N03", name: "Roger T Wong"),
                      tags: ["2017", "australia", "hobart", "parliamentlawns", "rogertwong", "sel85f18z", "sony85mmf18", "sonya7ii", "sonyalpha7ii", "sonyfe85mmf18", "sonyilce7m2", "tasmania", "tasteoftasmania", "movie", "screen"])
        ]
        return data
    }
}
