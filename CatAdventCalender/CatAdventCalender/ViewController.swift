//
//  ViewController.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Advent Calender 2022"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "D - 24", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
    }


}

