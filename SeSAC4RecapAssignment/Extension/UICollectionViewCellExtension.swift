//
//  UICollectionViewCellExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit

extension UICollectionViewCell: ReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
}
