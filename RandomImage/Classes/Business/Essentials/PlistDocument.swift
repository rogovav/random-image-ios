//
//  PlistDocument.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

private final class BundleToken {
}

struct PlistDocument {
    let data: [String: Any]

    init(path: String) {
        let bundle = Bundle(for: BundleToken.self)
        guard let url = bundle.url(forResource: path, withExtension: nil),
              let data = NSDictionary(contentsOf: url) as? [String: Any] else {
            fatalError("Unable to load PLIST at path: \(path)")
        }
        self.data = data
    }

    subscript<T>(key: String) -> T {
        guard let result = data[key] as? T else {
            fatalError("Property '\(key)' is not of type \(T.self)")
        }
        return result
    }
}