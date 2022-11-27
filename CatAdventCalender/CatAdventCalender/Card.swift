//
//  Card.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/27.
//

import Foundation

struct Card {
    var id: String = UUID().uuidString
    var shown: Bool = false
    var catImageURL: String
}
