//
//  UITableViewCellExtension.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit

extension UITableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
