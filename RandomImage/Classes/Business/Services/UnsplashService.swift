//
//  UnsplashService.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

class UnsplashService {
    static let shared = UnsplashService()

    let decoder = JSONDecoder()

    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getPhoto(_ id: String, response: @escaping (UnsplashImage?, Error?) -> Void) {
        UnsplashRequests.shared.requestData(id) { result in
            switch result {
            case let .success(data):
                do {
                    let image = try self.decoder.decode(UnsplashImage.self, from: data)
                    response(image, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case let .failure(error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }

    func loadImage(_ urlString: String?) -> UIImage? {
        guard let url = URL(string: urlString ?? "") else {
            return nil
        }

        var loadedImage: UIImage?

        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                loadedImage = image
            }
        }

        return loadedImage
    }
}
