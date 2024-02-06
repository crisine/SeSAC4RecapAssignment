//
//  UIViewControllerExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/20/24.
//

import UIKit

extension UIViewController: ReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
}
