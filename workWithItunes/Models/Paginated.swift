//
//  Paginated.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import ObjectMapper

struct Paginated<T: Mappable>: Mappable {
    var count: Int!
    var results: [T]!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        count <- map["resultCount"]
        results <- map["results"]
    }
}
