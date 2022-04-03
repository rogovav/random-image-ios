//
//  UnsplashImage.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

struct UnsplashImage: Decodable {
    let id: String?
    let likes: Int?
    let views: Int?
    let downloads: Int?
    let urls: ImageUrls?
    let user: UnsplashUserInfo?
}

struct ImageUrls: Decodable {
    let raw, full, regular, small, thumb, small_s3: String?
}