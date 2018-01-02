//
//  BaseInteractor.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseInteractor: class {}

/// The Entity
/// Entities encapsulate Enterprise wide business rules.
/// An entity can be an object with methods, or it can be a set of data structures and functions.
///
/// The Interactor
/// Interactors abstract rich business logic. They are the boundry between Presentation and Business (Domain) Logic
///
/// The Use Case
/// Use Cases have no knowledge of anything other than the business rules and Domain Entities which they're responsible for.
/// They can manipulate entities, however all communication with the outside world go through Gateways.
/// Use Cases are concreate implementations of Interactors and contain business logic.
protocol PhotoFeedInteractor: BaseInteractor {
    func getPublicFeed() -> Observable<[PhotoItem]>
}

protocol ScaledPhotoInteractor: BaseInteractor {
    func getLargePhoto(for: PhotoItem) -> PhotoItem
}
