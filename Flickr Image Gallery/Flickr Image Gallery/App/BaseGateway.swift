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

/// The (Entity) Gateway
/// An abstract boundary that encapsulates the semantic gap between the object-oriented domain layer represented by the Use Cases
/// and the relation-oriented persistence layer represented by the Repositiories.
///
/// The Repositiory
/// A Repository mediates between the data source and the business domain of the application.
/// It queries the data source for the data, maps the data from the data source to a business entity, and persists changes in the business entity to the data source.
/// A repository separates the business logic contained in the Use Cases from the interactions with the underlying data source or Web service.
/// Repositories are concrete implementations of gateways (boundaries).
protocol PhotoFeedGateway: BaseGateway {
    func getPublicFeed() -> Observable<[PhotoItem]>
}
