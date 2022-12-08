//
//  ImageViewController.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/27.
//

import UIKit

class ImageViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .customGreenColor
        imageView.layer.borderColor = UIColor.customGreenColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    var imageName: String
    var tapGesture = UITapGestureRecognizer()
    var panGesture = UIPanGestureRecognizer()
    let zoomOriginScale: CGFloat = 1.0
    
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
        
        scrollView.delegate = self
        scrollView.zoomScale = zoomOriginScale
        scrollView.minimumZoomScale = zoomOriginScale
        scrollView.maximumZoomScale = zoomOriginScale * 6
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        tapGesture.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(tapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureRecognizerHandler(_ panGesture: UIPanGestureRecognizer) {
        func slideViewVerticallyTo(_ y: CGFloat = 0) {
            self.view.frame.origin = CGPoint(x: 0, y: y)
        }
        
        switch panGesture.state {
        case .began, .changed:
            let translation = panGesture.translation(in: view)
            let y = max(0, translation.y)
            slideViewVerticallyTo(y)
        case .ended:
            let translation = panGesture.translation(in: view)
            if translation.y > self.view.frame.size.height * 0.2 {
                UIView.animate(withDuration: 0.2, animations: {
                    slideViewVerticallyTo(self.view.frame.size.height)
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    slideViewVerticallyTo()
                })
            }
        default:
            UIView.animate(withDuration: 0.2, animations: {
                slideViewVerticallyTo()
            })
        }
    }
    
    @objc func tapGestureRecognizerAction(tapGesture: UITapGestureRecognizer) {
        scrollView.zoomScale = zoomOriginScale
    }
    
    func setupView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
        
        let number = String(imageName.last!)
        
        if (Int(number) ?? 0) % 2 == 1 {
            imageView.layer.borderColor = UIColor.customGreenColor.cgColor
            imageView.backgroundColor = .customGreenColor
        } else {
            imageView.layer.borderColor = UIColor.customRedColor.cgColor
            imageView.backgroundColor = .customRedColor
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
