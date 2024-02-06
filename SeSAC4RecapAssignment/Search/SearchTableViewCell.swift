//
//  SearchTableViewCell.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconImageBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var searchKeywordLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var index: Int = 0
    var delegate: ButtonTappedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(keyword: String) {
        iconImageBackgroundView.backgroundColor = .backgroundColor
        iconImageBackgroundView.layer.borderColor = UIColor.clear.cgColor
        iconImageBackgroundView.layer.borderWidth = 1
        iconImageBackgroundView.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.iconImageBackgroundView.layer.cornerRadius = self.iconImageBackgroundView.frame.width / 2
        }
        
        iconImageView.image = UIImage(systemName: "magnifyingglass")
        iconImageView.tintColor = .white
        iconImageView.backgroundColor = .clear
        
        searchKeywordLabel.text = keyword
        searchKeywordLabel.font = .customFont(.description)
        searchKeywordLabel.textColor = .textColor
        
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .darkGray
        deleteButton.imageView?.contentMode = .scaleAspectFit
        
        self.backgroundColor = .backgroundColor
    }
    
    
    @IBAction func didDeleteButtonTapped(_ sender: UIButton) {
        self.delegate?.cellButtonTapped(index: index)
    }
}
