//
//  BookmarksDelegate.swift
//  RandomImage
//
//  Created by Alexander Rogov on 04.04.2022.
//

import Foundation

protocol BookmarksDelegate: AnyObject {
    func delete(_ id: String?)
    func getImage(_ id: String?, completion: ((ImageCardModel?) -> Void)?)
}


