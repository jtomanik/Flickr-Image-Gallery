//
//  ViewDisplayModel.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 30/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation

protocol BaseViewDisplayModel {
    var title: TextProvider { get }
    var backgroundColor: ColorProvider { get }
}

/// UIKit independent abstraction of generic view
struct ViewDisplayModel: BaseViewDisplayModel {
    let title: TextProvider
    let backgroundColor: ColorProvider
}
