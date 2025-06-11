//
//  ImageCacheManager.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

class ImageCacheManager {
    
    // MARK: - Private Cache Store
    static private var cache: [URL: Image] = [:]
    
    /// Static dictionary to store cached images using URL as the key
    static subscript(url: URL) -> Image? {
        get {
            ImageCacheManager.cache[url]
        }
        set {
            ImageCacheManager.cache[url] = newValue
        }
    }
}
