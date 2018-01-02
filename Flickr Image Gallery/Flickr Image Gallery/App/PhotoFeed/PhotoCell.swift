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
import RxSwift
import RxCocoa

final class PhotoCell: UITableViewCell {

    static let maxHeight: CGFloat = 250.0

    private let margin: CGFloat = 5.0
    private let spacing: CGFloat = 10.0

    private let photoView = UIImageView()
    private var imageHeightConstraint: NSLayoutConstraint?
    private var disposeBag = DisposeBag()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        photoView.kf.cancelDownloadTask()
        imageHeightConstraint?.constant = PhotoCell.maxHeight
        disposeBag = DisposeBag()
    }

    func set(displayModel model: PhotoThumbnailDisplayModel) {
        photoView.kf.setImage(with: model.url) { [weak self] (image, error, cacheType, url) in
            guard let image = image else {
                return
            }
            self?.updateHeight(imageSize: image.size)
        }
    }

    private func updateHeight(imageSize size: CGSize) {
        let maxWidth = contentView.frame.width - margin * 2
        let maxHeight = PhotoCell.maxHeight - spacing
        let height: CGFloat
        if size.height >= size.width {
            height = maxHeight
        } else {
            let widthRatio = maxWidth / size.width
            let imageHeight = size.height * widthRatio
            height = imageHeight
        }
        imageHeightConstraint?.constant = height
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }

    private func setupCell() {
        contentView.safelyAddSubview(photoView)
        photoView.marginToSuperview(top: spacing / 2, right: margin, bottom: spacing / 2, left: margin)
        photoView.contentMode = .scaleAspectFit
        if imageHeightConstraint == nil {
            imageHeightConstraint = contentView.getHeight(PhotoCell.maxHeight).withReducedPriority
            imageHeightConstraint?.activate()
        }
    }
}
