//
//  UserDefault.swift
//  RandomImage
//
//  Created by Alexander Rogov on 04.04.2022.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    private let userDefaults: UserDefaults = UserDefaults.standard

    var wrappedValue: T? {
        get {
            guard let modelData = userDefaults.data(forKey: key),
                  let model = try? JSONDecoder().decode(T.self, from: modelData)
                    else {
                return userDefaults.value(forKey: key) as? T
            }
            return model
        }
        set {
            if let newValue = newValue {
                let encodedData = try? JSONEncoder().encode(newValue)
                userDefaults.set(encodedData == nil ? newValue : encodedData, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
