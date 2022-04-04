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

    private let document = PlistDocument(path: "Info.plist")

    func requestData(_ id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let path = document["API_URL"] ?? ""
        let key = document["API_KEY"] ?? ""

        let stringUrl = "\(path)\(id)?client_id=\(key)"

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
                }
                .resume()
    }
}
