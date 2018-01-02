//
//  PhotoDetailViewController.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PhotoDetailViewController: BaseViewController {

    private var detailPresenter: PhotoDetailPresenter {
        return presenter as! PhotoDetailPresenter
    }

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.reloadData()
    }

    private func setupView() {
        view.safelyAddSubview(tableView)
        tableView.marginToSuperview(all: 0.0)
        tableView.backgroundColor = UIColor.clear
        tableView.register(PhotoPreviewCell.self)
        tableView.register(PhotoTitleCell.self)
        tableView.register(PhotoDescriptionCell.self)
        tableView.register(PhotoCopyrightCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
}

extension PhotoDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: PhotoPreviewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.set(displayModel: detailPresenter.getPhotoURL())
            return cell
        case 1:
            let cell: PhotoTitleCell = tableView.dequeueReusableCell(for: indexPath)
            cell.set(displayModel: detailPresenter.getPhotoTitle())
            return cell
        case 2:
            let cell: PhotoCopyrightCell = tableView.dequeueReusableCell(for: indexPath)
            cell.set(displayModel: detailPresenter.getPhotoCopyright())
            return cell
        case 3:
            let cell: PhotoDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            cell.set(displayModel: detailPresenter.getPhotoDescription())
            return cell
        default:
            fatalError("PhotoDetailViewController requested cell of invalid index: \(indexPath.debugDescription)")
        }
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
