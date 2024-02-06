//
//  ProfileImageSettingViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit

class ProfileImageSettingViewController: UIViewController {
    
    var profileImages: [String] = []
    var selectedImageName: String?
    
    @IBOutlet weak var profileImageCollectionView: UICollectionView!
    @IBOutlet weak var selectedProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageCollectionView.delegate = self
        profileImageCollectionView.dataSource = self

        configureNavigation()
        configureView()
        configureCollectionView()
        
        let imageName = UserDefaults.standard.string(forKey: "profileImage")
        var selectedIndex: Int?
        
        // MARK: Question - Asset 폴더 내의 특정 파일들을 regex등으로 떼오는 방법은 없을까?
        for index in 1...16 {
            let currentImageName = "profile\(index)"
            profileImages.append(currentImageName)
            
            if imageName == currentImageName {
                selectedIndex = index - 1
            }
        }
        
        if imageName == nil  {
            selectedImageName = "profile1"
        } else {
            selectedImageName = imageName
        }
        
        configureImageView()
        
        profileImageCollectionView.selectItem(at: IndexPath(item: selectedIndex!, section: 0), animated: true, scrollPosition: .top)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(selectedImageName, forKey: "profileImage")
    }
    
    func configureNavigation() {
        navigationItem.title = "프로필 설정"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.textColor,
                                                                   NSAttributedString.Key.font: UIFont.customFont(.primaryBoldTitle)]
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func configureView() {
        view.backgroundColor = .backgroundColor
        profileImageCollectionView.backgroundColor = .backgroundColor
    }
    
    func configureImageView() {
        guard let selectedImageName else { return }
        selectedProfileImageView.image = UIImage(named: selectedImageName)
        selectedProfileImageView.layer.borderColor = UIColor.pointColor.cgColor
        selectedProfileImageView.layer.borderWidth = 5
        selectedProfileImageView.contentMode = .scaleAspectFill
        selectedProfileImageView.clipsToBounds = true
        selectedProfileImageView.layer.cornerRadius = selectedProfileImageView.frame.width / 2
    }
}

extension ProfileImageSettingViewController: UICollectionViewDelegate,
                                             UICollectionViewDataSource {
    
    func configureCollectionView() {
        let xib = UINib(nibName: ProfileImageCollectionViewCell.identifier, bundle: nil)
        profileImageCollectionView.register(xib, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.setupLayoutEqually(itemsPerLine: 4.0)
        
        profileImageCollectionView.collectionViewLayout = layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        DispatchQueue.main.async {
            cell.configureImageView(imageName: self.profileImages[indexPath.row])
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell {
            cell.appearingAsSelected()
            
            selectedImageName = "profile\(indexPath.row + 1)"
            selectedProfileImageView.image = cell.profileImageView.image
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell {
            cell.appearingAsDeselected()
        }
    }
}
