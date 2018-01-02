//
//  PhotoPreviewCell.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class PhotoPreviewCell: BasePhotoDetailCell {

    private let photoView = UIImageView()
    private var heightConstraint: NSLayoutConstraint?

    override func prepareForReuse() {
        super.prepareForReuse()

        photoView.kf.cancelDownloadTask()
        heightConstraint?.constant = contentView.frame.width
    }

    func set(displayModel url: URL) {
        let maxWidth = contentView.frame.width
        photoView.kf.setImage(with: url) { [heightConstraint] (image, error, cacheType, url) in
            let widthRatio = maxWidth / (image?.size.width ?? 1.0)
            let imageHeight = (image?.size.height ?? 0.0) * widthRatio
            heightConstraint?.constant = imageHeight
        }
    }

    override func setupCell() {
        super.setupCell()

        contentView.safelyAddSubview(photoView)
        photoView.marginToSuperview(all: 0.0)
        heightConstraint = photoView.getHeight(contentView.frame.width).withReducedPriority
        heightConstraint?.activate()
    }
}
