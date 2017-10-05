//
//  Date.swift
//  workWithItunes
//
//  Created by noname on 05/10/2017.
//  Copyright © 2017 noname. All rights reserved.
//

import Foundation

extension Date {
    var formattedDate:String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            return formatter.string(from: self)
        }
    }
}
