//
//  TapLbl.swift
//  workWithItunes
//
//  Created by noname on 05/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import UIKit

class TapLbl: UILabel {
    
    var tapClosure: ((TapLbl) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc func didTap() {
        tapClosure?(self)
    }
    
    
}
