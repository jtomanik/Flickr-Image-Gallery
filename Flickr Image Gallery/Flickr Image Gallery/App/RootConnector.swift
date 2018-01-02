//
//  RootConnector.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

protocol BaseNavigator: class {
    func start() -> UIViewController
}

protocol PhotoFeedNavigator: BaseNavigator {
    func showDetail(photo: PhotoItem)
}

/// The Connector
/// The Connector is insired by the concepts of Coordinators, Flow Controllers or Routers.
/// Name Connector was chosen to avoid confusion, a Connector can ge describe as a component
/// that is responsible for lifecycle of Views and their dependencies.
/// It has following characteristics:
/// * Connector creates and configures instances of the Views (ViewControllers)
/// * Connector creates and configures instances of the Presenters
/// * Connector creates instances of dependencies
/// * Connector injects dependencies into the Use Case facade, Views and Presenters
/// * Connector shows and hides Views
final class RootConnector: BaseNavigator {

    private weak var rootViewController: UINavigationController!
    private let useCaseFacade: UseCaseFacade

    init() {
        let networkProvider: NetworkProvider = BaseRepository()
        let gateways = UseCaseFacade.Gateways(photoFeed: PhotoFeedRepository(networkProvider: networkProvider))
        useCaseFacade = UseCaseFacade(gateways: gateways)
    }

    func start() -> UIViewController {
        let vc = assemblePhotoFeed()
        rootViewController = UINavigationController(rootViewController: vc)
        defaultBackButton(navigationController: rootViewController)
        return rootViewController
    }

    private func assemblePhotoFeed() -> PhotoFeedViewController {
        let feedPresenter = PhotoFeedPresenter(interactor: useCaseFacade, navigator: self)
        let vc = PhotoFeedViewController(presenter: feedPresenter)
        vc.removeBackButtonTitle()
        return vc
    }

    private func assemblePhotoDetail(photo: PhotoItem) -> PhotoDetailViewController {
        let detailPresenter = PhotoDetailPresenter(interactor: useCaseFacade, navigator: self)
        detailPresenter.inject(model: photo)
        let vc = PhotoDetailViewController(presenter: detailPresenter)
        vc.removeBackButtonTitle()
        return vc
    }

    private func defaultBackButton(navigationController: UINavigationController) {
        let backArrowImage = Asset.NavBar.backGrey.image
        let renderedImage = backArrowImage.imageWithInset(insets: UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 0))
        navigationController.navigationBar.backIndicatorImage = renderedImage.withRenderingMode(.alwaysOriginal)
        navigationController.navigationBar.backIndicatorTransitionMaskImage = renderedImage
    }
}

extension RootConnector: PhotoFeedNavigator {

    func showDetail(photo: PhotoItem) {
        let vc = assemblePhotoDetail(photo: photo)
        rootViewController.pushViewController(vc, animated: true)
    }
}
