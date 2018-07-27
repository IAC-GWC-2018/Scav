//
//  Destination.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation
import MapKit

struct Destination: Hashable {
    let title: String
    let location: CLLocation
    let hints: [Hint]
    let id: Int
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func testDestination() -> [Destination] {
        return [Destination(title: "destination0", location: CLLocation(latitude: 88, longitude: 88), hints: Hint.testHint(), id: 0)]
    }
}
