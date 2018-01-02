//
//  PhotoCopyrightCell.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

final class PhotoCopyrightCell: BasePhotoDetailCell {

    private let authorLabel = UILabel()
    private let dateTakenLabel = UILabel()
    private let datePublishedLabel = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        dateTakenLabel.text = nil
        datePublishedLabel.text = nil
        authorLabel.text = nil
    }

    func set(displayModel model: PhotoCopyrightDisplayModel) {
        dateTakenLabel.text = model.dateTakenDescription
        datePublishedLabel.text = model.datePublishedDescription
        authorLabel.text = model.author
    }

    override func setupCell() {
        super.setupCell()

        contentView.safelyAddSubview(authorLabel)
        authorLabel.marginToSuperview(top: 10.0, left: 10.0)
        authorLabel.textAlignment = .left
        authorLabel.numberOfLines = 1

        contentView.safelyAddSubview(dateTakenLabel)
        dateTakenLabel.marginToSuperview(top: 10.0, right: 10.0)
        dateTakenLabel.textAlignment = .right
        dateTakenLabel.numberOfLines = 1

        contentView.safelyAddSubview(datePublishedLabel)
        datePublishedLabel.marginToSuperview(bottom: 10.0, left: 10.0)
        datePublishedLabel.below(view: authorLabel, withSpacing: 10.0)
        datePublishedLabel.textAlignment = .left
        datePublishedLabel.numberOfLines = 1
    }
}
