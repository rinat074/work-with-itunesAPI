//
//  ViewController.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class ViewController: UIViewController {
    
    lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search Album"
        s.delegate = self
        s.isTranslucent = false
        s.backgroundColor = .white
        s.tintColor = .white
        s.sizeToFit()
        return s
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    var albumManager: AlbumManager!
    var collectionView: UICollectionView!
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadUI() {
        //height constants
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let searchBarHeight: CGFloat = 50
        let yColectionView = searchBarHeight + statusBarHeight
        
        //collectionView setup
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionFrame = CGRect(x: 0, y: yColectionView, width: self.view.frame.size.width, height: self.view.frame.size.height - yColectionView)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        
        // statusBar not Translucent
        let statusBarView = UIView(frame: CGRect(x:0, y:0, width: self.view.frame.size.width, height: statusBarHeight))
        statusBarView.backgroundColor=UIColor.white
        statusBarView.alpha = 1
        self.view.addSubview(statusBarView)
        
        //search bar setup
        searchBar.frame = CGRect(x: 0, y: statusBarHeight, width: self.view.frame.size.width, height: searchBarHeight)
        self.view.addSubview(searchBar)
        
        activityIndicator.frame = CGRect(x: self.view.frame.size.height/2-15, y: self.view.frame.size.height-50, width: 30, height: 30)
        self.view.addSubview(activityIndicator)
        
        albumManager = AlbumManager(collectionView: collectionView, activityView: nil)
        collectionView.delegate = albumManager
        collectionView.dataSource = albumManager
        
        albumManager.didSelect = { [weak self] album in
            self?.showDetailsAlbum(album)
        }
    }
    
    func showDetailsAlbum(_ album: Album) {
        ItunesService.shared.getDetailsAlbum(id: album.id) { [weak self] (albumWithDetails) in
            let vc = DetailsAlbumVC.detailsAlbumVC(album: albumWithDetails)
            guard let strongSelf = self else {return}
            strongSelf.present(vc, animated: true, completion: nil)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != "" else { return }
        view.endEditing(true)
        albumManager.reset()
        albumManager.textSearch = text
        albumManager.fetchData()
    }
}

