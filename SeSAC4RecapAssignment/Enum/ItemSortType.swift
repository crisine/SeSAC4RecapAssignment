//
//  ItemSortType.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import Foundation

enum ItemSortType: Int {
    case sim
    case date
    case dsc
    case asc
    
    
    var query: String {
        switch self {
        case .sim:
            return "sim"
        case .date:
            return "date"
        case .dsc:
            return "dsc"
        case .asc:
            return "asc"
        }
    }
    
    var description: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .dsc:
            return "가격높은순"
        case .asc:
            return "가격낮은순"
        }
    }
}
