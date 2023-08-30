//
//  CardGachaViewController.swift
//  CatAdventCalender
//
//  Created by heyji on 2023/08/30.
//

import UIKit

class CardGachaViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var gachaButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        cardImageView.tintColor = .frashGreenColor
        cardImageView.layer.cornerRadius = 30
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layer.borderColor = UIColor.frashGreenColor.cgColor
        cardImageView.layer.borderWidth = 1
        
        gachaButton.layer.cornerRadius = 10
        gachaButton.backgroundColor = .frashGreenColor
        gachaButton.tintColor = .white
        gachaButton.addTarget(self, action: #selector(gachaButtonTapped), for: .touchUpInside)
    }
    
    @objc func gachaButtonTapped(_ sender: UIButton) {
        print("과연!")
        cardImageView.image = UIImage(named: "gift4")
    }
}
