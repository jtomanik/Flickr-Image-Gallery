//
//  ImageSizes.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 02/01/2018.
//  Copyright © 2018 Jakub Tomanik. All rights reserved.
//

import Foundation

/// based on https://www.flickr.com/services/api/misc.urls.html
enum ImageSizes: String {
    //s    small square 75x75
    case smallSquare = "s"
    //q    large square 150x150
    case largeSquare = "q"
    //t    thumbnail, 100 on longest side
    case thumbnail = "t"
    //m    small, 240 on longest side
    case small240 = "m"
    //n    small, 320 on longest side
    case small320 = "n"
    //-    medium, 500 on longest side
    case medium500 = "-"
    //z    medium 640, 640 on longest side
    case medium640 = "z"
    //c    medium 800, 800 on longest side†
    case medium800 = "c"
    //b    large, 1024 on longest side*
    case large1024 = "b"
    //h    large 1600, 1600 on longest side†
    case large1600 = "h"
    //k    large 2048, 2048 on longest side†
    case large2048 = "k"
    // * Before May 25th 2010 large photos only exist for very large original images.
    // † Medium 800, large 1600, and large 2048 photos only exist after March 1st 2012.
}
