//
//  PersistenceService.swift
//  RandomImage
//
//  Created by Alexander Rogov on 04.04.2022.
//

import Foundation

final class PersistenceService {
    // MARK: - Keys

    private enum UserDefaultsKeys: String {
        case lastData
        case bookmarks
    }

    // MARK: - Properties

    @UserDefault(key: UserDefaultsKeys.lastData.rawValue)
    var lastData: ImageCardModel?

    @UserDefault(key: UserDefaultsKeys.bookmarks.rawValue)
    private(set) var bookmarks: [String]?

    // MARK: - Lifecycle

    func updateBookmark(_ id: String) {
        if bookmarks != nil {
            let index = bookmarks?.firstIndex(of: id)
            if let index = index {
                bookmarks?.remove(at: index)
            } else {
                bookmarks?.append(id)
            }
        } else {
            bookmarks = [id]
        }
    }
}
