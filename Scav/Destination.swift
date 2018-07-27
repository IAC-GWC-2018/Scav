//
//  Destination.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation
import MapKit

struct Destination: Hashable, Codable {
    let title: String
    let location: HuntLocation
    let hints: [Hint]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case title, location, hints, id
    }
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func testDestination() -> [Destination] {
        return [Destination(title: "destination0", location: HuntLocation(latitude: 88, longitude: 88), hints: Hint.testHint(), id: 0)]
    }
}

