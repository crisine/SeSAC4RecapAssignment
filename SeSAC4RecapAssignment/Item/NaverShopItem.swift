//
//  Item.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import Foundation

// MARK: - NaverShop
struct NaverShopModel: Decodable {
//    let lastBuildDate: String
    let total, start, display: Int
    var items: [NaverShopItem]
}

// MARK: - Item
struct NaverShopItem: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType, brand: String
    
    enum CodingKeys: String, CodingKey {
            case title, link, image, lprice, hprice, mallName
            case productID = "productId"
            case productType, brand
    }
}

struct FavoritedItem: Hashable {
    var productId: String
}
