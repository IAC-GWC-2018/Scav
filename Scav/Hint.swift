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
        return [Hint(title: "hint0", caption: "hint0 caption", id: 0)]
    }
}
