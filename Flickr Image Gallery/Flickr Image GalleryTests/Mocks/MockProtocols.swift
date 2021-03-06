//
//  InvocationCountable.swift
//  Flickr Image GalleryTests
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

protocol InvocationCountable {
    var invocationCount: Int { get }
}

protocol ResultsExpectable {
    associatedtype ResutType
    var expected: ResutType { get }
}

class AnyResultsExpectable<T>: ResultsExpectable {

    let expected: T

    init<U: ResultsExpectable>(_ expectable: U) where U.ResutType == T {
        expected = expectable.expected
    }
}
