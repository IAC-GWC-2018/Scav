//
//  Hint.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

struct Hint: Codable {
    let description: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case description, id
    }

    static func testHint() -> [Hint] {
        return [Hint(description: "1", id: 0),
                Hint(description: "2", id: 0)]
    }
}
