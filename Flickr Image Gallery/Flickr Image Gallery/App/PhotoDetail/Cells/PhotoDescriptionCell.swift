//
//  PhotoDescriptionCell.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import WPAttributedMarkup

final class PhotoDescriptionCell: BasePhotoDetailCell {

    private let descriptionLabel = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        descriptionLabel.attributedText = nil
    }

    func set(displayModel description: String) {
        let attributedString = NSString(string: description).attributedString(withStyleBook: generateStyleDictionary())
        descriptionLabel.attributedText = attributedString
    }

    override func setupCell() {
        super.setupCell()

        contentView.safelyAddSubview(descriptionLabel)
        descriptionLabel.marginToSuperview(all: 10.0)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }

    /// more info at https://www.flickr.com/html.gne?tighten=0&type=description
    fileprivate func generateStyleDictionary() -> [AnyHashable : Any] {
        return [:]
    }
}
