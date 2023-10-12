//
//  StorageService.swift
//  Mileage
//
//  Created by ksd on 10/10/2023.
//

import Foundation


class StorageService {
    
    static func write<T: Encodable>(_ object: T, toJson file: String) {
        let homeFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let path = homeFolder?.appendingPathComponent(file) else {
            return
        }
        do {
            let data = try JSONEncoder().encode(object)
            print(path, data)
            try data.write(to: path)
        }
        catch {
            print("Could not write file \(path): \(error)")
        }
    }
    
    static func read(_ file: String) -> Data? {
        let homeFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let path = homeFolder?.appendingPathComponent(file) else {
            return nil
        }
//        Læser fra bundle som IKKE er samme sted som .documentDirectory
//        guard let path = Bundle.main.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
        
        guard let data = try? Data(contentsOf: path) else {
            return nil
        }
        return data
    }
}
















extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
