//
//  UIViewController+BackButton.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func defaultBackButton() {
        let backArrowImage = Asset.NavBar.backGrey.image
        let renderedImage = backArrowImage.imageWithInset(insets: UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 0))
        navigationController?.navigationBar.backIndicatorImage = renderedImage.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = renderedImage
    }
}

extension UIImage {

    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom
            ),
            false,
            self.scale
        )
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }
}
