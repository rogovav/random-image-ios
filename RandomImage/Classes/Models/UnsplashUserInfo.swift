//
//  UnsplashUserInfo.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

struct UnsplashUserInfo: Decodable {
    let id, username, name: String?
    let profileImage: UnsplashUserProfileImage?
}

struct UnsplashUserProfileImage: Decodable {
    let small, medium, large: String?
}