//
//  BaseGateway.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseGateway: class {}

/// Abstraction to hide implementation details and prevent tight coupling between Presenter and DataSource
protocol PhotoFeedGateway: BaseGateway {
    func getPublicFeed() -> Observable<[PhotoItem]>
}

protocol ScaledPhotoGateway: BaseGateway {
    func getLargePhoto(for: PhotoItem) -> PhotoItem
}
