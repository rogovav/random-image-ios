//
//  ImageInfoModel.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

struct ImageInfoModel {
    let likes: Int?
    let views: Int?
    let downloads: Int?

    static func fromUnsplashImage(_ model: UnsplashImage) -> ImageInfoModel {
        ImageInfoModel(likes: model.likes, views: model.views, downloads: model.downloads)
    }
}