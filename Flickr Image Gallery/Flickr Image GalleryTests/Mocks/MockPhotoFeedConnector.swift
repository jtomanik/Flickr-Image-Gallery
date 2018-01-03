//
//  MockPhotoFeedConnector.swift
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

final class MockPhotoFeedConnector: PhotoFeedNavigator {
    
    var timeShowDetailWasCalled = 0
    var passedPhoto: PhotoItem? {
        didSet {
            timeShowDetailWasCalled += 1
        }
    }

    func start() -> UIViewController {
        return UIViewController()
    }

    func showDetail(photo: PhotoItem) {
        passedPhoto = photo
    }
}
