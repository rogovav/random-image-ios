//
//  BookmarksVM.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

protocol BookmarksViewModel {
    func getItems(completion: (([String]) -> Void)?)
    func getImage(_ id: String, completion: ((ImageCardModel?, Bool) -> Void)?)
    func updateBookmark(_ id: String)
}

final class BookmarksVM: BookmarksViewModel {
    // MARK: - Properties

    let service = PersistenceService()

    // MARK: - MainViewModel

    func updateBookmark(_ id: String) {
        service.updateBookmark(id)
    }

    func getItems(completion: (([String]) -> Void)?) {
        guard let bookmarks = service.bookmarks else {
            completion?([])
            return
        }

        completion?(bookmarks)
    }

    func getImage(_ id: String, completion: ((ImageCardModel?, Bool) -> Void)?) {
        UnsplashService.shared.getPhoto(id) { [weak self] data, error in
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