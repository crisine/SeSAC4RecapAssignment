//
//  Utils.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import Foundation

struct Utils {
    static func formatStringNumberWithCommas(numberString: String) -> String {

        if let number = Double(numberString) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal

            if let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
                return formattedNumber
            }
        }

        return numberString
    }
    
    static func removeHTMLTags(from htmlString: String) -> String? {
        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            let plainText = attributedString.string
            return plainText
        } catch {
            // print("Error converting HTML to plain text: \(error)")
            return nil
        }
    }
}
