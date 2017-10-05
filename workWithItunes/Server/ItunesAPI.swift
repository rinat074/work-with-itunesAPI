//
//  ItunesAPI.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import Moya

enum ItunesAPI {
    case searchAlbum(text: String, limit: Int?, offset: Int?)
    case detailsalbum(id: Int)
}

extension ItunesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com/")!
    }
    var path: String {
        switch self {
        case .searchAlbum:
            return "search"
        case .detailsalbum:
            return "lookup"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String : Any]? {
        switch self {
        case .searchAlbum(let text, let limit, let offset):
            var params = [String:Any]()
            params["term"] = text
            if let limit = limit {
                params["limit"] = limit
            }
            if let offset = offset {
                params["offset"] = offset
            }
            params["entity"] = "album"
            return params
        case .detailsalbum(let id):
            return ["id":id]
        }
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
}
