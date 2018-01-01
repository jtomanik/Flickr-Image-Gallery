//
//  PhotoFeedConnector.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoFeedNavigator: class {
    func showDetail(photoId: String)
}

/// The Connector
/// The Connector is insired by the concepts of Coordinators, Flow Controllers or Routers.
/// Name Connector was chosen to avoid confusion, a Connector can ge describe as a component
/// that is responsible for lifecycle of Views and their dependencies.
/// In particular Connector is responsible for:
/// * Creating and configuring instances of the Views (ViewControllers)
/// * Creating instances of the Presenters
/// * Creating instances of dependencies
/// * injecting proper dependencies into the Views and Presenters
/// * Showing and Hiding of Views
final class PhotoFeedConnector {

    private struct Repositories {
        let photoFeedRepository: PhotoFeedRepository
    }

    private let repositiories: Repositories
    private weak var rootViewController: UINavigationController!

    init() {
        repositiories = Repositories(photoFeedRepository: PhotoFeedService())
    }

    func start() -> UIViewController {
        let vc = assemblePhotoFeed()
        rootViewController = UINavigationController(rootViewController: vc)
        return rootViewController
    }

    private func assemblePhotoFeed() -> PhotoFeedViewController {
        let feedPresenter = PhotoFeedPresenter(repository: repositiories.photoFeedRepository, navigator: self)
        return PhotoFeedViewController(presenter: feedPresenter)
    }
}

extension PhotoFeedConnector: PhotoFeedNavigator {

    func showDetail(photoId: String) {

    }
}
