//
//  AlbumManager.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit
import RxSwift
import AlamofireImage

class AlbumManager: NSObject, PaginatedManager {
    
    typealias T = Album
    
    var paginationInfo = PaginationInfo()
    var activityView: UIActivityIndicatorView?
    var collectionView: UICollectionView!
    var scheduler: SchedulerType = SerialDispatchQueueScheduler.init(qos: .background)
    var data: [Album] = [Album]()
    
    var textSearch: String = ""
    
    var didSelect: (Album) -> () = {_ in}
    
    func fetchRequest(limit: Int, offset: Int) -> ItunesAPI {
        return .searchAlbum(text: textSearch, limit: limit, offset: offset)
    }
    init(collectionView: UICollectionView, activityView: UIActivityIndicatorView? = nil) {
        self.collectionView = collectionView
        self.activityView = activityView
        self.collectionView.layer.masksToBounds = false
        self.collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension AlbumManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2
        let height: CGFloat = 140
        return CGSize(width: width, height: height)
    }
}

extension AlbumManager: UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.height, textSearch != "" else { return }
        self.fetchData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumCell
        let album = data[indexPath.row]
        if let artist = album.artist {
            cell.artistLbl.text = artist
        }
        if let photo = album.imageURL, let photoURL = URL(string: photo) {
            cell.imageAlbumView.af_setImage(withURL: photoURL)
        }
        cell.albumLbl.text = album.name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect(data[indexPath.row])
    }
}
