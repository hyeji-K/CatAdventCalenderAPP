//
//  ViewController.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Advent Calender 2022"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "D - 24", style: .plain, target: self, action: nil)
        
        setupView()
    }

    func setupView() {
        self.view.backgroundColor = .systemBrown
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.backgroundColor = .systemBrown
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(8)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
        let number = indexPath.item + 1
        if indexPath.item % 2 == 0 {
            cell.hiddenView.backgroundColor = .systemGreen
        } else {
            cell.hiddenView.backgroundColor = .systemRed
        }
        // TODO: PList 
        // Card.shown 이 false 면 cell.hiddenView.isHidden = false
        // true 면 cell.hiddenView.isHidden = true
//        cell.imageView.image = UIImage(named: "\(number)")
        cell.imageView.backgroundColor = .systemYellow
        cell.numberLabel.text = "\(number)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalenderCell
        let currentDate = Date().formatted(.dateTime.month(.defaultDigits).day())
        if "12/\(indexPath.item + 1)" == currentDate {
            let currentDay = currentDate.components(separatedBy: "/")
            if "\(indexPath.item + 1)" <= currentDay[1] {
                print("고양이 사진을 보여줍니다.")
                cell.showCard(false, animted: true)
            }
            
        } else {
            print("아직 날짜가 오지 않았어요!")
            let alert = UIAlertController(title: "아직 날짜가 오지 않았어요!", message: "조금만 더 기다려요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}
