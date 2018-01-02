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

    let displayModel = ViewDisplayModel(title: Localized.PhotoDetail.title,
                                               backgroundColor: ColorName.defaultBackground)

    private var model: PhotoItem!
    private var detailRepository: ScaledPhotoRepository {
        return repository as! ScaledPhotoRepository
    }

    override func configure() {
        super.configure()

        guard let oldModel = model else {
            fatalError("PhotoDetailPresenter not properly initiated")
        }

        model = detailRepository.getLargePhoto(for: oldModel)
    }

    func inject(model: PhotoItem) {
        self.model = model
    }

    func getPhotoTitle() -> String {
        return model.title
    }

    func getPhotoURL() -> URL {
        return model.mediaURL
    }

    func getPhotoDescription() -> String {
        return model.description
    }

    func getPhotoCopyright() -> PhotoCopyrightDisplayModel {
        return generateCopyright()
    }

    private func generateCopyright() -> PhotoCopyrightDisplayModel {
        return PhotoCopyrightDisplayModel(dateTakenDescription: LongDateFormatter.shared.string(from: model.dateTaken),
                                          datePublishedDescription: "\(Localized.PhotoDetail.publishedOn) \(ShortDateFormatter.shared.string(from: model.published))",
                                          author: "\(Localized.PhotoDetail.takenBy) \(model.author.name)")
    }
}
