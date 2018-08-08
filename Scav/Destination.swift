//
//  Destination.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation
import MapKit

struct Destination: Codable {
    let title: String
    let location: Location
    let hints: [Hint]
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title, location, hints, id
    }

    static func testDestination() -> [Destination] {
        return [Destination(title: "destination0", location: Location(latitude: 40.8888697, longitude: -74.2595486, id: 12), hints: Hint.testHint(), id: 0),Destination(title: "destination0", location: Location(latitude: 40.70251, longitude: -74.0169086, id: 11), hints: Hint.testHint(), id: 1)]
    }
}
