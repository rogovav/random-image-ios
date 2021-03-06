//
//  MainVM.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

protocol MainViewModel {
    func getImage(completion: ((ImageCardModel?, Bool) -> Void)?)
    func updateBookmark(_ id: String)
    func isBookmark(_ id: String) -> Bool
}

final class MainVM: MainViewModel {
    // MARK: - Properties

    let service = PersistenceService()

    // MARK: - MainViewModel

    func updateBookmark(_ id: String) {
        service.updateBookmark(id)
    }

    func isBookmark(_ id: String) -> Bool {
        service.bookmarks?.contains(id) ?? false
    }

    func getImage(completion: ((ImageCardModel?, Bool) -> Void)?) {
        UnsplashService.shared.getPhoto("random") { [weak self] data, error in
            guard let self = self else {
                return
            }
            if error == nil {
                guard let data = data else {
                    return
                }
                completion?(self.createImageCardModel(data), false)
            } else if (error?._code == NSURLErrorNotConnectedToInternet) {
                completion?(self.service.lastData, true)
            }
        }
    }

    // MARK: - Private

    private func createImageCardModel(_ data: UnsplashImage?) -> ImageCardModel? {
        guard let data = data else {
            return nil
        }

        var isBookmark = false

        if service.bookmarks != nil && data.id != nil {
            isBookmark = service.bookmarks!.contains(data.id!)
        }

        var model = ImageCardModel(
                id: data.id,
                userInfo: UserInfoModel(name: data.user?.name, userName: data.user?.username, image: nil),
                imageInfo: ImageInfoModel.fromUnsplashImage(data),
                image: nil,
                isBookmark: isBookmark
        )
        if let imageUrl = data.urls?.regular {
            model.image = UnsplashService.shared.loadImageData(imageUrl)
        }
        if let imageUrl = data.user?.profileImage?.small {
            model.userInfo?.image = UnsplashService.shared.loadImageData(imageUrl)
        }

        service.lastData = model

        return model
    }
}