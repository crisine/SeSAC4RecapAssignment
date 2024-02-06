//
//  ItemManager.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import Foundation

class NaverShopItemManager {
    
    static let shared = NaverShopItemManager()
    
    var favoritedItems = Set<String>() {
        didSet {
            print("좋아요 상품 갯수 : \(favoritedItems.count)")
            UserDefaults.standard.set(Array(favoritedItems), forKey: "favoritedItems")
        }
    }
    
    private init() { 
        print("private init called")
        if let savedFavoritedItems = UserDefaults.standard.object(forKey: "favoritedItems") as? [String] {
            favoritedItems = Set(savedFavoritedItems)
        }
    }
    
    func isFavorited(productId: String) -> Bool {
        return favoritedItems.contains(productId)
    }
}
