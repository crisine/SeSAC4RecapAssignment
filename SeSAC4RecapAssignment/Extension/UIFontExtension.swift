//
//  UIFontExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/20/24.
//

import UIKit

extension UIFont {
    
    static func customFont(_ name: SeSACFont) -> UIFont {		
        switch name {
        case .primaryBoldTitle:
            return boldSystemFont(ofSize: 17)
        case .secondaryBoldTitle:
            return boldSystemFont(ofSize: 15)
        case .secondaryTitle:
            return systemFont(ofSize: 15)
        case .description:
            return systemFont(ofSize: 13)
        }
    }
}
