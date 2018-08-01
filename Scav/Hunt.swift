//
//  Hunt.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

struct Hunt {
    let title: String
    let description: String
    let destinations: [Destination]
    
    static func testHunts() -> [Hunt] {
        return [Hunt(title: "hunt0", description: "hunt0 description", destinations: Destination.testDestination())]
    }

}
