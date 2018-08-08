//
//  JSON+Parsing.swift
//  Scav
//
//  Created by Mayki Hu on 8/1/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func parse<T: Decodable>(from json: [AnyHashable: Any], with keyDecodingStrategy: KeyDecodingStrategy = .useDefaultKeys) -> T?
    {
        self.keyDecodingStrategy = keyDecodingStrategy
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}

extension Encodable {
    func serialize() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
