//
//  HuntLocation.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

struct HuntLocation: Hashable, Codable {
    let latitude: Double
    let longitude: Double
    let id: Int
    
    var hashValue: Int {
        return id.hashValue
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, id
    }
}
