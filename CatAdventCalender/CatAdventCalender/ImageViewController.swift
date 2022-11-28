//
//  ImageViewController.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/27.
//

import UIKit

class ImageViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .customGreenColor
        imageView.layer.borderColor = UIColor.customGreenColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        imageView.image = UIImage(named: imageName)
    }
    
    func setupView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        let number = String(imageName.last!)
        
        if (Int(number) ?? 0) % 2 == 1 {
            imageView.layer.borderColor = UIColor.customGreenColor.cgColor
            imageView.backgroundColor = .customGreenColor
        } else {
            imageView.layer.borderColor = UIColor.customRedColor.cgColor
            imageView.backgroundColor = .customRedColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }
}
