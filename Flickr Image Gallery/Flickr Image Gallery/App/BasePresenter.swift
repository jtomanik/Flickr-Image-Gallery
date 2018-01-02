//
//  BasePresenter.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewConfigurator {
    var displayModel: BaseViewDisplayModel? { get }
}

extension BaseViewConfigurator {
    var displayModel: BaseViewDisplayModel? {
        return nil
    }
}

/// The Presenter
/// This Presenter is responsible for driving PhotoFeed screen.
/// It is a common ground between "Presenter" and "ViewModel" from two sister architectures MVP and MVVM,
/// It has following characteristics:
/// * Presenter is owned by the View
/// * Presenter contains all presentation logic
/// * Presenter contains the logic to handle user interactions
/// * Presenter provides reactive data binding mechanism to the View via DisplayModels to update Views's appearance automatically
/// * Presenter has no references to the View
/// * Presenter has all it's dependencies injected
/// * Presenter has no dependencies to UIKit
/// * Presenter can be easily tested
class BasePresenter: BaseViewConfigurator {

    let disposeBag = DisposeBag()

    unowned var repository: BaseRepository
    unowned var navigator: BaseNavigator

    init(repository: BaseRepository, navigator: BaseNavigator) {
        self.repository = repository
        self.navigator = navigator
    }

    /// `configure()` is called after the View is loaded
    func configure() {
    }

    /// `start()` is called everytime the View will be showed
    func start() {
    }

    /// `stop()` is called everytime the View disappeared
    func stop() {
    }
}
