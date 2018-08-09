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
        return [Hint(description: "This building's elevator goes up 104 stories in 47 seconds", id: 0),
                Hint(description: "Competed with The Chrysler Building to be the tallest building in NYC", id: 0),
                Hint(description: "2 of the GWC IAC interns work here.. in the bustling center of NYC", id: 0),
                Hint(description: "Museum designed by famous architect", id: 0)]
    }
}
