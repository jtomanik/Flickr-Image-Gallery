//
//  PhotoFeedViewController.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 27/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PhotoFeedViewController: BaseViewController {

    private var feedPresenter: PhotoFeedPresenter {
        return presenter as! PhotoFeedPresenter
    }

    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }()
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionViewSpacing: CGFloat = 16.0
    private let elements = Variable(0)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        elements.asObservable()
            .subscribe(onNext: { [collectionView] _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupView() {

        feedPresenter.items
            .drive(elements)
            .disposed(by: disposeBag)

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
        collectionView.delegate = self

        collectionViewLayout.sectionInset = UIEdgeInsets(top: collectionViewSpacing,
                                                         left: collectionViewSpacing,
                                                         bottom: collectionViewSpacing,
                                                         right: collectionViewSpacing)
        collectionViewLayout.minimumInteritemSpacing = collectionViewSpacing
        collectionViewLayout.minimumLineSpacing = collectionViewSpacing
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = PhotoCell.estimatedCellSize
    }
}

extension PhotoFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.value
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(displayModel: feedPresenter.getDisplayModel(forElement: indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        feedPresenter.selectedItem(atIndex: indexPath.item)
    }
}
