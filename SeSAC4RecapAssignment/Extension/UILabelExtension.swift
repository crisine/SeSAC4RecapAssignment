//
//  UILabelExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/29/24.
//

import UIKit

extension UILabel {
    
    func configureStyle(font: UIFont = .systemFont(ofSize: 16),
                        text: String,
                        textColor: UIColor = .black,
                        backgroundColor: UIColor = .clear,
                        alignStyle: NSTextAlignment = .left,
                        numberOfLines: Int = 0) {
        
        self.font = font
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = alignStyle
        self.numberOfLines = numberOfLines
    }
    
}
