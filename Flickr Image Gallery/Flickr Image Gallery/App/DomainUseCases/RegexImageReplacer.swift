//
//  RegexImageReplacer.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

final class RegexImageReplacer {

    static let shared = RegexImageReplacer()

    private let searchPattern = "<img.*?alt=\\\"(.*?)\" .*?>"
    private let replaceTemplate = "$1"

    private let regex: NSRegularExpression

    private init() {
        regex = try! NSRegularExpression(pattern: searchPattern, options: .caseInsensitive)
    }

    func replace(in input: String) -> String {
        let result = regex.stringByReplacingMatches(in: input,
                                                    options: [],
                                                    range: NSRange.init(location: 0, length: input.count),
                                                    withTemplate: replaceTemplate)
        return result
    }
}
