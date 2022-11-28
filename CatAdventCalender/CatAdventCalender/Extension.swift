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

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    static var customGreenColor: UIColor {
        UIColor(named: "customGreenColor") ?? UIColor(hex: 0x65634C)
    }
    
    static var customRedColor: UIColor {
        UIColor(named: "customRedColor") ?? UIColor(hex: 0x96463B)
    }
    
    static var customBrownColor: UIColor {
        UIColor(named: "customBrownColor") ?? UIColor(hex: 0xB99F86)
    }
    
    static var customBrackColor: UIColor {
        UIColor(named: "customBrackColor") ?? UIColor(hex: 0x2A2017)
    }
}
