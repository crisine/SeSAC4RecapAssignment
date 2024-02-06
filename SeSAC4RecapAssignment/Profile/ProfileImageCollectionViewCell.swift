//
//  ProfileImageCollectionViewCell.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureImageView(imageName: String) {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.image = UIImage(named: imageName)
        
        if self.isSelected {
            print("selected")
            appearingAsSelected()
        } else {
            appearingAsDeselected()
        }
    }
    
    func appearingAsSelected() {
        profileImageView.layer.borderColor = UIColor.pointColor.cgColor
        profileImageView.layer.borderWidth = 5
    }
    
    func appearingAsDeselected() {
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.layer.borderWidth = 0
    }
}
