//
//  UserDefaultsService.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import Foundation

protocol Storable {
    associatedtype DataType: Codable
    func retrieve(key: String) -> DataType?
}

protocol Writable {
    associatedtype DataType: Codable
    func save(value: DataType, key: String)
}

final class UserDefaultsService<T: Codable>: Storable, Writable {
    typealias DataType = T
    private let userDefaults = UserDefaults.standard

    func retrieve(key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            print("Decoding error: $$error)")
            return nil
        }
    }

    func save(value: T, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Encoding error: $$error)")
        }
    }
}
