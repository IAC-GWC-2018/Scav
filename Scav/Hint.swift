//
//  Hint.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

struct Hint: Hashable {
    let title: String
    let caption: String
    let id: Int
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func testHint() -> [Hint] {
        return [Hint(title: "1", caption: "This is a hint!", id: 0),
                Hint(title: "2", caption: "This is another hint!", id: 0),
                Hint(title: "3", caption: "This is a third hint!", id: 0),
                Hint(title: "4", caption: "This is a 4th hint!", id: 0)]
    }
}
