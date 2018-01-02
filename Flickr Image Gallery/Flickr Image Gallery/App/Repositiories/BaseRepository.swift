//
//  BaseRepository.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseRepository: class {}

/// Abstraction to hide implementation details and prevent tight coupling between Presenter and DataSource
protocol PhotoFeedRepository: BaseRepository {
    func getPublicFeed() -> Observable<[PhotoItem]>
}

protocol ScaledPhotoRepository: BaseRepository {
    func getLargePhoto(for: PhotoItem) -> PhotoItem
}
