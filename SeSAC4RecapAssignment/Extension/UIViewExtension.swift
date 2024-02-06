//
//  UIViewExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/29/24.
//

import UIKit

extension UIView {
    
    func configureStyle(backgroundColor: UIColor = .white,
                        isRounded: Bool? = false,
                        cornerRadius: CGFloat = 0) {
        
        self.backgroundColor = backgroundColor
        
        if let isRounded {
            self.clipsToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
}
