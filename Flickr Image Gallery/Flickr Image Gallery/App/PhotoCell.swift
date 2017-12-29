//
//  PhotoCell.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 29/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {

    static let estimatedCellSize = CGSize(width: 250, height: 250)

    private let photoView = UIImageView()

    private var model: PhotoItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        model = nil
        photoView.kf.cancelDownloadTask()
    }

    func set(model: PhotoItem) {
        self.model = model

        photoView.kf.setImage(with: model.media.m)
    }

    private func setupView() {
        contentView.setWidth(PhotoCell.estimatedCellSize.width)
        contentView.setHeight(PhotoCell.estimatedCellSize.height)

        contentView.safelyAddSubview(photoView)
        photoView.marginToSuperview(all: 0.0)
    }
}
