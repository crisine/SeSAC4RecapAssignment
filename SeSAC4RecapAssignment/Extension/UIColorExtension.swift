//
//  UIColorExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/20/24.
//

import UIKit

@objc
extension UIColor {
    open class var pointColor: UIColor {
        return UIColor(red: 73/255, green: 220/255, blue: 146/255, alpha: 1)
    }
    
    open class var backgroundColor: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    open class var textColor: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    open class var veryDarkColor: UIColor {
        return UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    }
}
