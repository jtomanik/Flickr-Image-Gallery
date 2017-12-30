//
//  PhotoListViewController.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 27/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// The View
/// Views and view controllers are technically distinct components, yet on iOS they almost always go hand-in-hand together, paired.
/// I want to formalize this connection and call UIView-UIViewController pair the View.
/// It has following characteristics:
/// * View owns the Presenter
/// * View contains all the layout logic
/// * View contains all the necessary subviews
/// * View delegates user interactions to the Presenter
/// * View's appearance is controlled through DisplayModels that encapsulate all data to be presented
/// * View binds to reactive properties of the presenter to get updates aboub DisplayModel changes
final class PhotoListViewController: UIViewController {

    private var presenter: PhotoFeedPresenter!

    private let collectionView: UICollectionView
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionViewSpacing: CGFloat = 16.0
    private let elements = Variable(0)
    private let disposeBag = DisposeBag()

    convenience init(presenter: PhotoFeedPresenter) {
        self.init(nibName: nil, bundle: nil)
        self.presenter = presenter
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
        presenter.configure()

        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.start()

        elements.asObservable()
            .subscribe(onNext: { [collectionView] _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        presenter.stop()
    }

    private func setupView() {
        title = presenter.displayModel.title
        view.backgroundColor = presenter.displayModel.backgroundColor.color

        presenter.items
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

extension PhotoListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.value
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(displayModel: presenter.getDisplayModel(forElement: indexPath.item))
        return cell
    }
}
