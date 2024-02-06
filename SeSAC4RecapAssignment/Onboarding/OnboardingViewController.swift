//
//  OnboardingViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/20/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureImageViews()
    }
    
    func configureImageViews() {
        titleImageView.image = UIImage(named: "sesacShopping")
        centerImageView.image = UIImage(named: "onboarding")
    }
    
    func configureView() {
        view.backgroundColor = .backgroundColor

        startButton.tintColor = .pointColor
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = .customFont(.primaryBoldTitle) // MARK: 미적용
    }
    
    
    @IBAction func didStartButtonTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
