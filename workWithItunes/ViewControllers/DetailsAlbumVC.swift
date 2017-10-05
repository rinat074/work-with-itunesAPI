//
//  DetailsAlbumVC.swift
//  workWithItunes
//
//  Created by noname on 05/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsAlbumVC: UIViewController {
    
    var album: Album!
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Back", for: .normal)
        btn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var imageAlbumView: UIImageView = {
        let imageAlbumView = UIImageView()
        imageAlbumView.contentMode = .scaleAspectFit
        imageAlbumView.translatesAutoresizingMaskIntoConstraints = false
        return imageAlbumView
    }()
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var albumLbl: TapLbl = {
        let lbl = TapLbl()
        lbl.textColor = UIColor.darkGray
        lbl.font = lbl.font.withSize(15)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var artistLbl: TapLbl = {
        let lbl = TapLbl()
        lbl.textColor = UIColor.black
        lbl.font = lbl.font.withSize(17)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = lbl.font.withSize(14)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = lbl.font.withSize(13)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        setupAlbum()
    }
    
    func setupAlbum() {
        guard let album = album else {return}
        albumLbl.text = album.name
        if let urlAlbum = album.itunesAlbumUrl {
            albumLbl.tapClosure = { _ in
                UIApplication.shared.openURL(URL(string: urlAlbum)!)
            }
        }
        if let artist = album.artist {
            artistLbl.text = artist
            if let urlArtist = album.itunesArtistUrl {
                artistLbl.tapClosure = { _ in
                    UIApplication.shared.openURL(URL(string: urlArtist)!)
                }
            }
        }
        if let price = album.price, let currency = album.currency {
            priceLbl.text = "\(price) \(currency)"
        }
        if let date = album.releaseDate {
            dateLbl.text = date.formattedDate
        }
        if let photo = album.imageURL, let photoURL = URL(string: photo) {
            imageAlbumView.af_setImage(withURL: photoURL)
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        topView.addSubview(backBtn)
        backBtn.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        backBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view.addSubview(imageAlbumView)
        imageAlbumView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15).isActive = true
        imageAlbumView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        imageAlbumView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageAlbumView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15).isActive = true
        stackView.leftAnchor.constraint(equalTo: imageAlbumView.rightAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        
        stackView.addArrangedSubview(artistLbl)
        stackView.addArrangedSubview(albumLbl)
        stackView.addArrangedSubview(priceLbl)
        stackView.addArrangedSubview(dateLbl)
    }
    
    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    class func detailsAlbumVC(album: Album) -> DetailsAlbumVC {
        let vc = DetailsAlbumVC()
        vc.album = album
        return vc
    }
    
}
