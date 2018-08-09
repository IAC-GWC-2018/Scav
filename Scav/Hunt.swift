//
//  Hunt.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

struct Hunt: Codable {
    let title: String
    let description: String
    let destinations: [Destination]
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title, description, destinations, id
    }

    static func testHunts() -> [Hunt] {
        return [Hunt(title: "Demo", description: "A tour of NYC!", destinations: Destination.testDestination(), id: 0)]
    }
}
