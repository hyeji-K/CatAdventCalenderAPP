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
    
    func showCard(_ show: Bool, animted: Bool) {
        hiddenView.isHidden = false
        imageView.isHidden = false
        
        if animted {
            if show {
                UIView.transition(
                    from: imageView,
                    to: hiddenView,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { (finished: Bool) -> () in
                    })
            } else {
                UIView.transition(
                    from: hiddenView,
                    to: imageView,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion:  { (finished: Bool) -> () in
                    })
            }
        } else {
            if show {
                bringSubviewToFront(hiddenView)
                imageView.isHidden = true
            } else {
                bringSubviewToFront(imageView)
                hiddenView.isHidden = true
            }
        }
    }
}
