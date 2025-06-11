//
//  ImageCacheManager.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

class ImageCacheManager {
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCacheManager.cache[url]
        }
        set {
            ImageCacheManager.cache[url] = newValue
        }
    }
}
