//
//  EnumeratedImages.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/29/24.
//

import UIKit

enum EnumeratedImages {
    
    case person
    case magnifyingglass
    case xmark
    case heart
    case heartFill
    
    var image: UIImage! {
        switch self {
        case .person:
            return UIImage(systemName: "person")
        case .magnifyingglass:
            return UIImage(systemName: "magnifyingglass")
        case .xmark:
            return UIImage(systemName: "xmark")
        case .heart:
            return UIImage(systemName: "heart")
        case .heartFill:
            return UIImage(systemName: "heart.fill")
        }
    }
}
