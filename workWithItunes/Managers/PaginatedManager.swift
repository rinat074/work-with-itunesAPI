//
//  PaginatedManager.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import ObjectMapper

protocol SortableModel {
    var id: Int! {get set}
    var name: String {get set}
}

struct PaginationInfo {
    var isFinished: Bool = false
    var offset: Int = 0
    var limit: Int = 50
    var page: Int {
        get {
            return offset/limit
        }
        
        set {
            offset = newValue * limit
        }
    }
}

protocol PaginatedManager: class {
    associatedtype T:SortableModel, Mappable
    
    var paginationInfo: PaginationInfo {get set}
    var activityView: UIActivityIndicatorView? {get}
    var collectionView: UICollectionView! {get}
    var scheduler: SchedulerType {get}
    var data: [T] {get set}
    
    /// Return Moya request for fetching
    ///
    /// - Parameters:
    ///   - limit: page size
    ///   - offset: items offset
    func fetchRequest(limit: Int, offset: Int) -> ItunesAPI
    
}

extension PaginatedManager {
    func reset() {
        data = [T]()
        paginationInfo.page = 0
        paginationInfo.isFinished = false
    }
    
    /// Fecth data from a server
    func fetchData() {
        guard !paginationInfo.isFinished else { return }
        if let activity = activityView {
            if activity.isAnimating { return }
        }
        startLoading()
        AppDelegate.shared.itunesAPI.request(fetchRequest(limit: paginationInfo.limit,
                                                           offset: paginationInfo.offset))
            .filterSuccessfulStatusCodes()
            .observeOn(scheduler)
            .map({ (response) -> Paginated<T> in
                let json = try response.mapJSON()
                let result = Paginated<T>(JSON: json as! [String:Any])
                return result!
            })
            .do(onNext: { page in
                self.paginationInfo.isFinished = page.results.isEmpty
                self.paginationInfo.page += 1
            })
            .flatMap({ page -> Observable<T> in
                return Observable.from(page.results)
            })
            .filter { item -> Bool in
                for index in 0..<self.data.count {
                    let cashed = self.data[index]
                    if cashed.id == item.id {
                        self.data[index] = item
                        return false
                    }
                }
                return true
            }.do(onNext: { item in
                for index in 0..<self.data.count {
                    let cashed = self.data[index]
                    if cashed.name.lowercased() > item.name.lowercased() {
                        self.data.insert(item, at: index)
                        return
                    }
                }
                self.data.append(item)
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onDisposed: {
                self.stopLoading()
                self.collectionView.reloadData()
            }).addDisposableTo(AppDelegate.shared.disposeBag)
    }
    
    func startLoading() {
        activityView?.startAnimating()
        activityView?.isHidden = false
    }
    
    func stopLoading() {
        activityView?.stopAnimating()
        activityView?.isHidden = true
    }
}
