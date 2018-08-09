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
    
    static var worldTradeHint: Hint {
        return Hint(description: "This building's elevator goes up 104 stories in 47 seconds", id: 0)
    }
    
    static var worldTradeHint2: Hint {
        return Hint(description: "This building was completed November 3, 2014", id: 0)
    }
    
    static var empireHint: Hint {
        return Hint(description: "Competed with The Chrysler Building to be the tallest building in NYC", id: 0)
    }
    
    static var dotDashHint: Hint {
        return Hint(description: "2 of the GWC IAC interns work here.. in the bustling center of NYC", id: 0)
    }
    
    static var museumHint: Hint {
        return Hint(description: "Museum designed by famous architect", id: 0)
    }

}
