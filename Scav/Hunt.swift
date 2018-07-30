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
    
    enum CodingKeys: String, CodingKey {
        case title, description, destinations
    }
        
    static func getHunts(completion: (([Hunt], Error?) -> Void)) {
        
        HuntNetworkManager.shared.process(.getHunts) { (data, response, error) in
            if (error != nil) {
                print(error!)
            }
        }
        
        
    }
    
    static func testHunts() -> [Hunt] {
        return [Hunt(title: "hunt0", description: "hunt0 description", destinations: Destination.testDestination())]
    }
    
    func toData() -> Data {
        return Data()
    }
    
}
