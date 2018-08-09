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
        return [Destination(title: "World Trade Center", location: Location(latitude: 40.7118011, longitude: -74.0131196, id: 12), hints: Hint.testHint(), id: 0),Destination(title: "Empire State Building", location: Location(latitude: 40.7485413, longitude: -73.9857577, id: 11), hints: Hint.testHint(), id: 1),Destination(title: "Dotdash", location: Location(latitude: 40.7567644, longitude: -73.9857192, id: 11), hints: Hint.testHint(), id: 1),Destination(title: "Guggenheim", location: Location(latitude: 40.7829796, longitude: -73.9589706, id: 11), hints: Hint.testHint(), id: 1)]
    }
}
