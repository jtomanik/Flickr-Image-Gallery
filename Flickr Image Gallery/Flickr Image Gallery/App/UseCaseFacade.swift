//
//  UseCaseFacade.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import RxSwift

/// The Use Case
/// Use Cases have no knowledge of anything other than the business rules and Domain Entities which they're responsible for.
/// They can manipulate entities, however all communication with the outside world go through Gateways.
/// Use Cases are concreate implementations of Interactors and contain business logic.
final class UseCaseFacade: BaseInteractor {

    struct Gateways {
        let photoFeed: PhotoFeedGateway
    }

    private let gateways: Gateways

    init(gateways: Gateways) {
        self.gateways = gateways
    }
}

extension UseCaseFacade: PhotoFeedInteractor {

    func getPublicFeed() -> Observable<[PhotoItem]> {
        return gateways.photoFeed.getPublicFeed()
    }
}

extension UseCaseFacade: ScaledPhotoInteractor {

    func getLargePhoto(for item: PhotoItem) -> PhotoItem {
        return ScaledPhotoUseCase().getLargePhoto(for: item)
    }
}
