//
//  SearchedItemDetailViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit
import WebKit

class SearchedItemDetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var mainWebView: WKWebView!

    var urlString: String?
    var navTitle: String?
    var productId: String?
    
    var favoriteButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        
        navigationItem.title = navTitle
        navigationController?.navigationBar.topItem?.title = ""
        
        guard let productId else { return }
        urlString = "https://msearch.shopping.naver.com/product/\(productId)"
        
        if let url = URL(string: urlString!) {
            let urlReq = URLRequest(url: url)
            print("webview Loading")
            mainWebView.load(urlReq)
        }
        
        favoriteButton = UIButton(type: .custom)
        
        if let favoriteButton {
            if NaverShopItemManager.shared.isFavorited(productId: productId) {
                appearingFavoriteButtonAsFavorited()
            } else {
                appearingFavoriteButtonAsNotFavorited()
            }
            
            favoriteButton.addTarget(self, action: #selector(didFavoriteButtonTapped), for: .touchUpInside)

            let favoriteBarButtonItem = UIBarButtonItem(customView: favoriteButton)
            
            navigationItem.rightBarButtonItem = favoriteBarButtonItem
        }
    }
    
    func appearingFavoriteButtonAsFavorited() {
        if let favoriteButton {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    func appearingFavoriteButtonAsNotFavorited() {
        if let favoriteButton {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc func didFavoriteButtonTapped() {
        
        guard let productId else { return }
        
        switch NaverShopItemManager.shared.isFavorited(productId: productId) {
        case true:
            NaverShopItemManager.shared.favoritedItems.remove(productId)
            appearingFavoriteButtonAsNotFavorited()
        case false:
            NaverShopItemManager.shared.favoritedItems.insert(productId)
            appearingFavoriteButtonAsFavorited()
        }
    }
}
