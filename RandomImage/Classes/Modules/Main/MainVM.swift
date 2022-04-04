//
//  MainVM.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

protocol MainViewModel {
    func getImage(completion: ((ImageCardModel?) -> Void)?)
    func addBookmark(_ id: String)
    func deleteBookmark(_ id: String)
}

final class MainVM: MainViewModel {
    func addBookmark(_ id: String) {
        print("added: \(id)")
    }

    func deleteBookmark(_ id: String) {
        print("deleted: \(id)")
    }

    func getImage(completion: ((ImageCardModel?) -> Void)?) {
        UnsplashService.shared.getPhoto("random") { [weak self] data, error in
            if error == nil {
                guard let data = data else {
                    return
                }
                guard let self = self else {
                    return
                }
                completion?(self.setImageCardModel(data))
            }
        }
    }

    private func setImageCardModel(_ data: UnsplashImage?) -> ImageCardModel? {
        guard let data = data else {
            return nil
        }
        var model = ImageCardModel(
                id: data.id,
                userInfo: UserInfoModel(name: data.user?.name, userName: data.user?.username, image: nil),
                imageInfo: ImageInfoModel.fromUnsplashImage(data),
                image: nil
        )
        if let imageUrl = data.urls?.regular {
            model.image = UnsplashService.shared.loadImage(imageUrl)
        }
        if let imageUrl = data.user?.profileImage?.small {
            model.userInfo?.image = UnsplashService.shared.loadImage(imageUrl)
        }
        return model
    }
}