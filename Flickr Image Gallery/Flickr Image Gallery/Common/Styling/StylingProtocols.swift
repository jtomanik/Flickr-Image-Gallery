//
//  StylingProtocols.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 30/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit

protocol ColorProvider {
    var color: UIColor { get }
}

typealias TextProvider = String

protocol ImageProvider {
    var image: UIImage { get }
}
