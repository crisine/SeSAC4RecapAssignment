//
//  ItemCollectionViewCell.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    var item: NaverShopItem?
    var delegate: ButtonTappedDelegate?
    var productId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(item: NaverShopItem) {
        configureImageView(item: item)
        configureView(item: item)
        self.item = item
    }
    
    func configureImageView(item: NaverShopItem) {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        if let url = URL(string: item.image) {
            imageView.kf.setImage(with: url)
        }
    }

    func configureView(item: NaverShopItem) {
        imageViewBackgroundView.backgroundColor = .clear
        
        favoriteButton.tintColor = .white
    
        guard let productId else { return }
        
        // MARK: favorited 여부에 따라 (item고유 넘버로 판단) heart.fill 혹은 heart
        if NaverShopItemManager.shared.isFavorited(productId: productId) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        favoriteButton.clipsToBounds = true
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        favoriteButton.contentMode = .scaleAspectFit
        
        shopNameLabel.font = .customFont(.description)
        shopNameLabel.textColor = .gray
        shopNameLabel.text = item.mallName
        
        itemNameLabel.font = .customFont(.secondaryTitle)
        itemNameLabel.textColor = .white
        itemNameLabel.numberOfLines = 2
        
        if let itemName = Utils.removeHTMLTags(from: item.title) {
            itemNameLabel.text = itemName
        }
        
        priceLabel.font = .customFont(.primaryBoldTitle)
        priceLabel.textColor = .white
        priceLabel.text = Utils.formatStringNumberWithCommas(numberString: item.lprice)
    }
    
    
    @IBAction func didFavoriteButtonTapped(_ sender: UIButton) {
        
        guard let productId else { return }
        
        if NaverShopItemManager.shared.isFavorited(productId: productId) {
            NaverShopItemManager.shared.favoritedItems.remove(productId)
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            NaverShopItemManager.shared.favoritedItems.insert(productId)
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    
    // MARK: Not working...
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        print("prepareForReuse호출")
        imageView.image = nil
        shopNameLabel.text = nil
        itemNameLabel.text = nil
        priceLabel.text = nil
        favoriteButton.imageView?.image = nil
    }
}
