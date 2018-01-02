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

    private let tableView = UITableView()
    private let elements = Variable(0)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        elements.asObservable()
            .subscribe(onNext: { [tableView] _ in
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupView() {

        feedPresenter.items
            .drive(elements)
            .disposed(by: disposeBag)

        setupTableView()
    }

    func setupTableView() {
        view.safelyAddSubview(tableView)
        tableView.marginToSuperview(all: 0.0)
        tableView.backgroundColor = UIColor.clear
        tableView.register(PhotoCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
}

extension PhotoFeedViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.value
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PhotoCell = tableView.dequeueReusableCell(for: indexPath)
        cell.set(displayModel: feedPresenter.getDisplayModel(forElement: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        feedPresenter.selectedItem(atIndex: indexPath.row)
        return false
    }
}
