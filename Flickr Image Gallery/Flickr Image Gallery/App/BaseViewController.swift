//
//  BaseViewController.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 01/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// The View
/// Views and View Controllers are technically distinct components, yet on iOS they almost always go hand-in-hand together, paired.
/// I want to formalize this connection and call UIView-UIViewController pair the View.
/// It has following characteristics:
/// * View owns the Presenter
/// * View contains all the layout logic
/// * View contains all the necessary subviews
/// * View delegates user interactions to the Presenter
/// * View's appearance is controlled through DisplayModels that encapsulate all data to be presented
/// * View binds to reactive properties of the presenter to get updates about DisplayModel changes
class BaseViewController: UIViewController {

    var presenter: BasePresenter!
    let disposeBag = DisposeBag()

    convenience init(presenter: BasePresenter) {
        self.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        presenter.stop()
    }

    private func setupView() {
        guard let presenter = presenter as? BaseViewConfigurator else {
            return
        }
        title = presenter.displayModel.title
        view.backgroundColor = presenter.displayModel.backgroundColor.color
    }
}
