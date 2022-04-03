//
//  UnsplashRequests.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import Foundation

class UnsplashRequests {
    static let shared = UnsplashRequests()

    private init() {
    }

    func requestData(_ id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let stringUrl = "https://api.unsplash.com/photos/\(id)?client_id=\(apiKey)"

        guard let url = URL(string: stringUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
}
