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
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: toItem,
                                            attribute: toAttribute,
                                            multiplier: 1.0,
                                            constant: constant)
        constraint.isActive = true
    }

    func alignRight(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: toItem,
                                            attribute: toAttribute,
                                            multiplier: 1.0,
                                            constant: constant)
        constraint.isActive = true
    }

    func alignTop(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: toItem,
                                            attribute: toAttribute,
                                            multiplier: 1.0,
                                            constant: constant)
        constraint.isActive = true
    }

    func alignBottom(_ toItem: UIView, toAttribute: NSLayoutAttribute, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: toItem,
                                            attribute: toAttribute,
                                            multiplier: 1.0,
                                            constant: constant)
        constraint.isActive = true
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
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: height)
        constraint.isActive = true
    }

    func setWidth(_ width: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: width)
        constraint.isActive = true
    }
}
