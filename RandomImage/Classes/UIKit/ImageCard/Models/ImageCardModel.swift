//
//  ImageCardModel.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

struct ImageCardModel: Codable {
    let id: String?
    var userInfo: UserInfoModel?
    var imageInfo: ImageInfoModel?
    var image: Data?
    var isBookmark: Bool
}