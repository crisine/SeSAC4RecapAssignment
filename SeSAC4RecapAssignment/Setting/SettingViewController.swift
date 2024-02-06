//
//  SettingViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var profileAreaView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var favoritedProductsLabel: UILabel!
    @IBOutlet weak var followingTextLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    
    var favoritedItems = NaverShopItemManager.shared.favoritedItems {
        didSet {
            favoritedProductsLabel.text = "\(favoritedItems.count)개의 상품"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        configureView()
        configureImageView()
        configureTableView()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritedItems = NaverShopItemManager.shared.favoritedItems
        updateProfile()
    }
    
    func configureView() {
        view.backgroundColor = .backgroundColor
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        profileAreaView.backgroundColor = .veryDarkColor
        profileAreaView.clipsToBounds = true
        profileAreaView.layer.cornerRadius = 8
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileAreaTapped(_:)))
        profileAreaView.addGestureRecognizer(tapGesture)
        profileAreaView.isUserInteractionEnabled = true
        
        usernameLabel.text = username ?? "defaultUser"
        usernameLabel.font = .customFont(.primaryBoldTitle)
        usernameLabel.textColor = .textColor
        
        favoritedProductsLabel.text = "\(favoritedItems.count)개의 상품"
        favoritedProductsLabel.font = .customFont(.secondaryTitle)
        favoritedProductsLabel.textColor = .pointColor
        
        followingTextLabel.text = "을 좋아하고 있어요!"
        followingTextLabel.font = .customFont(.secondaryTitle)
        followingTextLabel.textColor = .textColor
    }
    
    func configureImageView() {
        
        if let imageName = UserDefaults.standard.string(forKey: "profileImage") {
            profileImageView.image = UIImage(named: imageName)
        }
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        profileImageView.layer.borderWidth = 5
    }
    
    func configureNavigation() {
        navigationItem.title = "설정"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.textColor,
                                                                   NSAttributedString.Key.font: UIFont.customFont(.primaryBoldTitle)]
    }

    @objc func profileAreaTapped(_ gesture: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateProfile() {
        if let imageName = UserDefaults.standard.string(forKey: "profileImage") {
            profileImageView.image = UIImage(named: imageName)
        }
        
        let username = UserDefaults.standard.string(forKey: "username")
        usernameLabel.text = username ?? "defaultUser"
    }
}

extension SettingViewController: UITableViewDelegate,
                                 UITableViewDataSource {
    
    func configureTableView() {
        settingTableView.alwaysBounceVertical = false
        settingTableView.backgroundView?.backgroundColor = .veryDarkColor
        settingTableView.backgroundColor = .veryDarkColor
        settingTableView.clipsToBounds = true
        settingTableView.layer.cornerRadius = 8
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return SettingMenus.menu.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingTableViewCell", for: indexPath)
        
        cell.backgroundColor = .veryDarkColor
        cell.textLabel?.text = SettingMenus.menu[indexPath.row]
        cell.textLabel?.font = .customFont(.secondaryTitle)
        cell.textLabel?.textColor = .textColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let index = indexPath.row
        
        guard index == 4 else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        guard index == 4 else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = Alert.createAlert(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", okTitle: "확인") {
            
            UserDefaults.standard.removeObject(forKey: "UserState")
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "profileImage")
            UserDefaults.standard.removeObject(forKey: "favoritedItems")
            UserDefaults.standard.removeObject(forKey: "searchedKeywords")
            
            NaverShopItemManager.shared.favoritedItems.removeAll()
            RecentSearch.keywords.removeAll()
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as! OnboardingViewController
            let nav = UINavigationController(rootViewController: vc)
            
            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
