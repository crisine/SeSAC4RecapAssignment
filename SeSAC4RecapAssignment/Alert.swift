//
//  Alert.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit

struct Alert {
    static func createAlert(title: String? = nil, message: String? = nil, okTitle: String, okAction: @escaping () -> Void) -> UIAlertController {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in okAction() }
        vc.addAction(okAction)
        return vc
    }
}
