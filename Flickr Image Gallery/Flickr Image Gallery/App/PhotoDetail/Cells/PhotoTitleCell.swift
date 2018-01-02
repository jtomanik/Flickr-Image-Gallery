//
//  PhotoTitleCell.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

final class PhotoTitleCell: BasePhotoDetailCell {

    private let titleLabel = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
    }

    func set(displayModel title: String) {
        titleLabel.text = title
    }

    override func setupCell() {
        super.setupCell()

        contentView.safelyAddSubview(titleLabel)
        titleLabel.marginToSuperview(all: 10.0)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
}
