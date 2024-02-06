//
//  UIButtonExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit

extension UIButton {
    
    func changeFont(font: UIFont) {
        self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = font
            return outgoing
        }
    }
}
