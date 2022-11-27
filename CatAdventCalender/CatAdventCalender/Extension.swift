//
//  Extension.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/27.
//

import UIKit

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
