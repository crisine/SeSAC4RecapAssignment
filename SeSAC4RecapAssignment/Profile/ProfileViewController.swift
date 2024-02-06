//
//  ProfileViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/20/24.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileCornerIconImageView: UIImageView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nickNameUnderLineview: UIView!
    @IBOutlet weak var nicknameStatusLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    var isValidNickname: Bool = false
    var profileImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
        configureImageView()
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
        
        confirmButton.tintColor = .pointColor
        confirmButton.setTitle("완료", for: .normal)
        confirmButton.titleLabel?.font = .customFont(.primaryBoldTitle)
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        nicknameTextField.backgroundColor = .black
        nicknameTextField.font = .customFont(.secondaryTitle)
        nicknameTextField.textColor = .textColor
        
        nickNameUnderLineview.backgroundColor = .gray
        
        nicknameStatusLabel.textColor = .pointColor
        nicknameStatusLabel.text = "2글자 이상 10글자 미만의 닉네임을 입력해주세요"
        nicknameStatusLabel.font = .customFont(.description)
        
        profileView.backgroundColor = .clear
    }
    
    func configureImageView() {
        
        profileImageName = UserDefaults.standard.string(forKey: "profileImage")
        
        if profileImageName == nil {
            UserDefaults.standard.set("profile1", forKey: "profileImage")
            profileImageName = "profile1"
        }
        profileImageView.image = UIImage(named: profileImageName ?? "profile1")
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didProfileImageViewTapped)))
        
        profileCornerIconImageView.image = UIImage(named: "camera")
        profileCornerIconImageView.contentMode = .scaleAspectFill
        profileCornerIconImageView.clipsToBounds = true
        profileCornerIconImageView.layer.cornerRadius = profileCornerIconImageView.frame.width / 2
    }
    
    
    
    @IBAction func didChangedTextOnNicknameTextField(_ sender: UITextField) {
    
        guard let text = sender.text else { return }
        
        if text.count < 2 || text.count > 10 {
            nicknameStatusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요."
        } else if text.range(of: "[@#$%]", options: .regularExpression) != nil {
            nicknameStatusLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
        } else if text.range(of: "[0-9]", options: .regularExpression) != nil {
            nicknameStatusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
        } else {
            nicknameStatusLabel.text = "사용할 수 있는 닉네임이에요"
            isValidNickname = true
            return
        }
        
        isValidNickname = false
    }
    
    
    @objc func didProfileImageViewTapped(_ sender: UIImageView) {
        let sb = UIStoryboard(name: "ProfileImageSetting", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileImageSettingViewController.identifier) as! ProfileImageSettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func didConfirmButtonTapped(_ sender: UIButton) {
        
        guard isValidNickname else { return }
        
        // MARK: 닉네임이 정상적일 경우 처리
        // 1. UserDefaults에 닉네임 저장 잊지 말기
        // 2. Window 통해서 View 옮기기.
        // 3. UserDefaults에서 Onboarding 값 없애기.
        
        let nickname = nicknameTextField.text
        
        UserDefaults.standard.setValue(nickname, forKey: "username")
        
        guard UserDefaults.standard.bool(forKey: "UserState") != true else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        UserDefaults.standard.set(true, forKey: "UserState")
        
        // 아예 처음부터 하는 중
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
