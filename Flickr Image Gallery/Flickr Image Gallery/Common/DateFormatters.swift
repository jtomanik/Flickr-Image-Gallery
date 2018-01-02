//
//  DateFormatters.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

final class ShortDateFormatter {

    static let shared = ShortDateFormatter()

    var dateFormat: String {
        return dateFormatter.dateFormat
    }

    private let dateFormatter = DateFormatter()

    private init() {
        dateFormatter.dateFormat = "dd/MM/YYYY"
    }

    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}

final class LongDateFormatter {

    static let shared = LongDateFormatter()

    var dateFormat: String {
        return dateFormatter.dateFormat
    }

    private let dateFormatter = DateFormatter()

    private init() {
        dateFormatter.dateFormat = "d MMMM YYYY"
    }

    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}

final class ISODateFormatter {

    static let shared = ISODateFormatter()

    private let dateFormatter = ISO8601DateFormatter()

    private init() {
        dateFormatter.formatOptions = .withInternetDateTime
    }

    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
