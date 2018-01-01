//
//  PhotoDetailPresenter.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PhotoDetailPresenter: BasePresenter {

    private var photoId: String!
    private var detailRepository: PhotoFeedRepository {
        return repository as! PhotoFeedRepository
    }

    override func configure() {
        super.configure()

        guard let id = photoId else {
            fatalError("PhotoDetailPresenter not properly initiated")
        }
    }

    func inject(modelId id: String) {
        photoId = id
    }

    func getPhotoTitle() -> Driver<String> {
        return Driver.just("Long title")
    }

    func getPhotoURL() -> Driver<URL> {
        return Driver.just(URL(fileURLWithPath: ""))
    }

    func getPhotoDescription() -> Driver<String> {
        return Driver.just("Description")
    }

    func getPhotoCopyright() -> Driver<PhotoCopyrightDisplayModel> {
        let mock = PhotoCopyrightDisplayModel(dateTakenDescription: "",
                                              datePublishedDescription: "",
                                              author: "")
        return Driver.just(mock)
    }
}