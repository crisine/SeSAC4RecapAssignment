//
//  UICollectionViewFlowLayoutExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    func setupLayoutEqually(itemsPerLine: Double) {
        let itemSize = (UIScreen.main.bounds.width / itemsPerLine) - 16
        self.itemSize = CGSize(width: itemSize, height: itemSize)
        self.minimumLineSpacing = 16
        self.minimumInteritemSpacing = 8
        self.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.scrollDirection = .vertical
    }
    
    func setupLayout(itemsPerLine: Double, height: Double) {
        let itemSize = (UIScreen.main.bounds.width / itemsPerLine) - 8
        self.itemSize = CGSize(width: itemSize, height: height)
        self.minimumLineSpacing = 8
        self.minimumInteritemSpacing = 2
        self.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.scrollDirection = .vertical
    }
}
