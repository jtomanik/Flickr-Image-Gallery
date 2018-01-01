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

final class PhotoCell: UICollectionViewCell {

    static let estimatedCellSize = CGSize(width: 250, height: 250)

    private let photoView = UIImageView()
    private var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        photoView.kf.cancelDownloadTask()
        disposeBag = DisposeBag()
    }

    func set(displayModel: Driver<PhotoDisplayModel>) {

        displayModel
            .drive(onNext: { [photoView] model in
                photoView.kf.setImage(with: model.url)
            })
            .disposed(by: disposeBag)
    }

    private func setupView() {
        contentView.setWidth(PhotoCell.estimatedCellSize.width)
        contentView.setHeight(PhotoCell.estimatedCellSize.height)

        contentView.safelyAddSubview(photoView)
        photoView.marginToSuperview(all: 0.0)
    }
}
