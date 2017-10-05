//
//  ItunesService.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit

class ItunesService {
    static var shared: ItunesService {
        get {
            return ItunesService()
        }
    }
    //Methods work with API
    func getDetailsAlbum(id: Int, completionHandler handler: @escaping (Album) -> Void) {
        AppDelegate.shared.itunesAPI.request(.detailsalbum(id: id))
            .filterSuccessfulStatusCodes()
            .map({ (response) -> Paginated<Album> in
                let json = try response.mapJSON()
                let result = Paginated<Album>(JSON: json as! [String:Any])
                return result!
            })
            //.mapArray(Album.self)
            .subscribe(onNext: { (response) in
                if response.count > 0, let result = response.results.first {
                    handler(result)
                }
            }).addDisposableTo(AppDelegate.shared.disposeBag)
    }
}
