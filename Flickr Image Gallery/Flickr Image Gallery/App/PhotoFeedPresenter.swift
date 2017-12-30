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

/// This Presenter is responsible for driving PhotoFeed screen.
/// It is a common ground between "Presenter" and "ViewModel" from two sister architectures MVP and MVVM,
/// It has following characteristics:
/// * Presenter is owned by the View
/// * Presenter contains all presentation logic
/// * View delegates user interactions to the Presenter
/// * Presenter contains the logic to handle user interactions
/// * Presenter provides reactive data binding mechanism to the View to update it's appearance automatically
/// * View's appearance is controlled through DisplayModels that encapsulate all data to be presented
/// * Presenter has no references to the View
/// * Presenter has all it's dependencies injected
/// * Presenter has no dependencies to UIKit
/// * Presenter can be easily tested
final class PhotoFeedPresenter {

    public let displayModel = ViewDisplayModel(title: Localized.PhotoList.title,
                                                 backgroundColor: ColorName.defaultBackground)

    public var items: Driver<Int> {
        return models.asDriver()
            .map { $0.count }
    }

    private let repository: PhotoFeedRepository
    private let models = Variable<[PhotoItem]>([])
    private let refreshTrigger = BehaviorSubject<Void>(value: ())
    private let disposeBag = DisposeBag()

    init(repository: PhotoFeedRepository) {
        self.repository = repository
    }

    /// `configure()` is called after the View is loaded
    func configure() {
        refreshTrigger
            .flatMap { [repository] _ in repository.getPublicFeed() }
            .bind(to: models)
            .disposed(by: disposeBag)
    }

    /// `start()` is called everytime the View will be showed
    func start() {
        refreshTrigger.onNext(())
    }

    /// `stop()` is called everytime the View disappeared
    func stop() {

    }

    // `refresh()` is called to refresh Presenter's state
    func refresh() {
        refreshTrigger.onNext(())
    }

    func getDisplayModel(forElement index: Int) -> Driver<PhotoDisplayModel> {
        return models.asDriver()
            .map { $0[index].toDisplayModel() }
    }
}

fileprivate extension PhotoItem {

    func toDisplayModel() -> PhotoDisplayModel {
        return PhotoDisplayModel(url: self.media.m)
    }
}
