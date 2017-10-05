//
//  Album.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import ObjectMapper

struct Album: Mappable, SortableModel {
    var id: Int!
    var artist: String?
    var name: String = ""
    var imageURL: String?
    
    var itunesAlbumUrl: String?
    var itunesArtistUrl: String?
    var price: Double?
    var currency: String?
    var releaseDate: Date?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["collectionId"]
        artist <- map["artistName"]
        name <- map["collectionName"]
        imageURL <- map["artworkUrl100"]
        
        itunesAlbumUrl <- map["collectionViewUrl"]
        itunesArtistUrl <- map["artistViewUrl"]
        price <- map["collectionPrice"]
        currency <- map["currency"]
        releaseDate <- (map["releaseDate"], CustomDateFormatTransform(formatString: "YYYY-MM-dd'T'HH:mm:ssZ"))
    }
}
