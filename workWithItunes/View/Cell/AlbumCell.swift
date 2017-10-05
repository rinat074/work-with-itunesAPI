//
//  AlbumCell.swift
//  workWithItunes
//
//  Created by noname on 04/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    lazy var imageAlbumView: UIImageView = {
        let imageAlbumView = UIImageView()
        imageAlbumView.contentMode = .scaleAspectFit
        imageAlbumView.translatesAutoresizingMaskIntoConstraints = false
        return imageAlbumView
    }()
    
    lazy var albumLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.font = lbl.font.withSize(12)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.text = "Album"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var artistLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = lbl.font.withSize(12)
        lbl.textAlignment = .center
        lbl.text = "Artist"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageAlbumView)
        addSubview(albumLbl)
        addSubview(artistLbl)
        
        albumLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        albumLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        albumLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        albumLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        artistLbl.bottomAnchor.constraint(equalTo: albumLbl.topAnchor, constant: -5).isActive = true
        artistLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        artistLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        artistLbl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        imageAlbumView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        imageAlbumView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        imageAlbumView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        imageAlbumView.bottomAnchor.constraint(equalTo: artistLbl.topAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
