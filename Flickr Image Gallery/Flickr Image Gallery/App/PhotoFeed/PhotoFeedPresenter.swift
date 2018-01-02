//
//  PhotoFeedPresenter.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 29/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PhotoFeedPresenter: BasePresenter, BaseViewConfigurator {

    let displayModel: BaseViewDisplayModel = ViewDisplayModel(title: Localized.PhotoList.title,
                                                 backgroundColor: ColorName.defaultBackground)

    var items: Driver<Int> {
        return models.asDriver()
            .map { $0.count }
    }

    private var feedUseCase: PhotoFeedInteractor {
        return useCaseFacade as! PhotoFeedInteractor
    }
    private var feedConnector: PhotoFeedNavigator {
        return connector as! PhotoFeedNavigator
    }

    private let models = Variable<[PhotoItem]>([])
    private let refreshTrigger = BehaviorSubject<Void>(value: ())

    override func configure() {
        super.configure()

        refreshTrigger
            .flatMapLatest { [feedUseCase] _ in feedUseCase.getPublicFeed() }
            .bind(to: models)
            .disposed(by: disposeBag)
    }

    override func start() {
        super.start()

        refreshTrigger.onNext(())
    }

    // `refresh()` is called to refresh Presenter's state
    func refresh() {
        refreshTrigger.onNext(())
    }

    func getDisplayModel(forElement index: Int) -> PhotoThumbnailDisplayModel {
        return models.value[index].toDisplayModel()
    }

    func selectedItem(atIndex index: Int) {
        let item = models.value[index]
        feedConnector.showDetail(photo: item)
    }
}

fileprivate extension PhotoItem {

    func toDisplayModel() -> PhotoThumbnailDisplayModel {
        return PhotoThumbnailDisplayModel(url: self.mediaURL)
    }
}
