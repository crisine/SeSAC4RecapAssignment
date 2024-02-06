//
//  RecentSearch.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import Foundation

struct RecentSearch {
    static var keywords: [String] = UserDefaults.standard.object(forKey: "searchedKeywords") as? [String] ?? []
}
