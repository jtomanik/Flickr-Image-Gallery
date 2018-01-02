//
//  UIView+Autolayout.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 29/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import UIKit

extension UIView {

    func safelyAddSubview(_ view: UIView) {
        if !self.subviews.contains(view) {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }

    func alignLeft(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        NSLayoutConstraint.activate([getAlignedLeft(toItem: toItem,
                                                    toAttribute: toAttribute,
                                                    constant: constant)
        ])
    }

    func getAlignedLeft(toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .left, toItem: toItem, toAttribute: toAttribute, constant: constant)
    }

    func alignRight(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        NSLayoutConstraint.activate([getAlignedRight(toItem: toItem,
                                                     toAttribute: toAttribute,
                                                     constant: constant)
        ])
    }

    func getAlignedRight(toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .right, toItem: toItem, toAttribute: toAttribute, constant: constant)
    }

    func alignTop(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        NSLayoutConstraint.activate([getAlignedTop(toItem: toItem,
                                                   toAttribute: toAttribute,
                                                   constant: constant)
        ])
    }

    func getAlignedTop(toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .top, toItem: toItem, toAttribute: toAttribute, constant: constant)
    }

    func alignBottom(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        NSLayoutConstraint.activate([getAlignedBottom(toItem: toItem,
                                                      toAttribute: toAttribute,
                                                      constant: constant)
        ])
    }

    func getAlignedBottom(toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .bottom, toItem: toItem, toAttribute: toAttribute, constant: constant)
    }

    func marginToSuperview(top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
        guard top != nil || right != nil || bottom != nil || left != nil else {
            return assertionFailure("Calling marginToSuperview() results in nothing being done. Are you sure?")
        }

        if let superview = self.superview {
            if let top = top {
                self.alignTop(superview, toAttribute: .top, constant: top)
            }

            if let right = right {
                superview.alignRight(self, toAttribute: .right, constant: right)
            }

            if let bottom = bottom {
                superview.alignBottom(self, toAttribute: .bottom, constant: bottom)
            }

            if let left = left {
                self.alignLeft(superview, toAttribute: .left, constant: left)
            }
        }
    }

    func marginToSuperview(all: CGFloat? = nil) {
        marginToSuperview(top: all, right: all, bottom: all, left: all)
    }

    func setHeight(_ height: CGFloat) {
        NSLayoutConstraint.activate([getHeight(height)])
    }

    func getHeight(_ height: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .height,
                              toItem: nil,
                              toAttribute: .notAnAttribute,
                              constant: height)
    }

    func setWidth(_ width: CGFloat) {
        NSLayoutConstraint.activate([getWidth(width)])
    }

    func getWidth(_ width: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .width,
                              toItem: nil,
                              toAttribute: .notAnAttribute,
                              constant: width)
    }

    func below(view: UIView, withSpacing spacing: CGFloat) {
        NSLayoutConstraint.activate([getBelow(view: view, withSpacing: spacing)])
    }

    func getBelow(view: UIView, withSpacing spacing: CGFloat) -> NSLayoutConstraint {
        return makeConstraint(attribute: .top,
                              toItem: view,
                              toAttribute: .bottom,
                              constant: spacing)
    }

    func horizontallyCenter(toView: UIView? = nil, withOffset: CGFloat? = nil) {
        let offset = withOffset ?? 0
        let refView = toView ?? self.superview
        let constraintX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: refView, attribute: .centerX, multiplier: 1.0, constant: offset)

        constraintX.isActive = true
    }

    func centerInSuperView() {
        let constraintX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)

        let constraintY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)

        constraintX.isActive = true
        constraintY.isActive = true
    }

    private func makeConstraint(attribute: NSLayoutAttribute, toItem: UIView?, toAttribute: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: toItem,
                                  attribute: toAttribute,
                                  multiplier: 1.0,
                                  constant: constant)
    }
}

extension NSLayoutConstraint {

    func activate() {
        NSLayoutConstraint.activate([self])
    }

    var withReducedPriority: NSLayoutConstraint {
        self.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        return self
    }
}
