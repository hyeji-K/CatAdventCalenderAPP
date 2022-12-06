//
//  CalenderCell.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/25.
//

import UIKit

class CalenderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    func showCard() {
        UIView.transition(
            from: hiddenView,
            to: imageView,
            duration: 0.5,
            options: [.transitionFlipFromRight, .showHideTransitionViews],
            completion:  { (finished: Bool) -> () in
            })
    }
}
