//
//  ViewController.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer?
    var targetDate: Date = Date()
    lazy var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .brief
        return formatter
    }()
    var gifts: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Advent Calender 2022"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundImage = UIImage(named: "background")
        appearance.shadowImage = UIImage()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance

        setupView()
        
        let christmasDate = "2022-12-25 00:00:00".date!
        targetDate = christmasDate
        formatDuration(from: Date(), to: targetDate)
        
        let targetPath = getFileName("ChristmasGift.plist")

        guard let sourcePath = Bundle.main.path(forResource: "ChristmasGift", ofType: "plist") else { return }
        
        let FileManager = FileManager.default
        if !FileManager.fileExists(atPath: targetPath) {
            do {
                try FileManager.copyItem(atPath: sourcePath, toPath: targetPath)
            } catch {
                print("복사 실패")
            }
        }
        self.gifts = NSMutableArray(contentsOfFile: targetPath)
        
        LocalNotification.shared.sendNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        formatDuration(from: Date(), to: targetDate)
        
        LocalNotification.shared.removeNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Personal preference
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked(_:)), userInfo: nil, repeats: true)
        self.timer = timer
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func getFileName(_ fileName: String) -> String {
        let docDirs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docPath = docDirs[0] as NSString
        let fullPath = docPath.appendingPathComponent(fileName)
        return fullPath
    }
    
    @objc func timerTicked(_ timer: Timer) {
        formatDuration(from: Date(), to: targetDate)
    }
    
    func formatDuration(from: Date, to: Date) {
        let text = durationFormatter.string(from: to.timeIntervalSince(from))
        timerLabel.text = text
    }

    func setupView() {
        self.view.backgroundColor = .customBrownColor
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout()
        collectionView.backgroundColor = .customBrownColor
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(8)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let gifts = gifts {
            return gifts.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
        
        guard let gifts = self.gifts,
              let gift = gifts[indexPath.item] as? [String: Any]
        else { return cell }
        if gift["shown"] as! Int == 0 {
            cell.hiddenView.isHidden = false
            if indexPath.item % 2 == 0 {
                cell.hiddenView.backgroundColor = .customGreenColor
            } else {
                cell.hiddenView.backgroundColor = .customRedColor
            }
        } else {
            cell.hiddenView.isHidden = true
        }
        
        if indexPath.item % 2 == 0 {
            cell.imageView.layer.borderWidth = 2
            cell.imageView.layer.borderColor = UIColor.customGreenColor.cgColor
        } else {
            cell.imageView.layer.borderWidth = 2
            cell.imageView.layer.borderColor = UIColor.customRedColor.cgColor
        }
        
        let imageName = gift["image"] as! String
        cell.imageView.image = UIImage(named: imageName)
        cell.imageView.backgroundColor = .systemYellow
        cell.imageView.contentMode = .scaleAspectFill
        cell.numberLabel.text = gift["number"] as? String
        
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
                
                guard let gifts = self.gifts,
                      var gift = gifts[indexPath.item] as? [String: Any]
                else { return }
                gift["shown"] = 1
                gifts[indexPath.item] = gift
                gifts.write(toFile: getFileName("ChristmasGift.plist"), atomically: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let imageName = gift["image"] as! String
                    let viewController = ImageViewController(imageName: imageName)
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .overFullScreen
                    self.present(viewController, animated: true)
                }
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
