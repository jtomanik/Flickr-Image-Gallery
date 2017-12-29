//
//  PhotoListViewController.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 27/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import UIKit

final class PhotoListViewController: UIViewController {

    private let collectionView: UICollectionView
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionViewSpacing: CGFloat = 16.0

    private let feedService = PhotoFeedService()
    private var models: [PhotoItem] = []

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }

    private func setupView() {
        title = L10n.Photolist.title
        view.backgroundColor = ColorName.defaultBackground.color
        setupCollectionView()
    }

    private func setupCollectionView() {
        view.safelyAddSubview(collectionView)

        collectionView.marginToSuperview(all: 0.0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(PhotoCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        collectionView.dataSource = self

        collectionViewLayout.sectionInset = UIEdgeInsets(top: collectionViewSpacing,
                                                         left: collectionViewSpacing,
                                                         bottom: collectionViewSpacing,
                                                         right: collectionViewSpacing)
        collectionViewLayout.minimumInteritemSpacing = collectionViewSpacing
        collectionViewLayout.minimumLineSpacing = collectionViewSpacing
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = PhotoCell.estimatedCellSize
    }

    private func fetchData() {
        models = feedService.getPublicFeed()
        collectionView.reloadData()
    }
}

extension PhotoListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(model: models[indexPath.item])
        return cell
    }
}
