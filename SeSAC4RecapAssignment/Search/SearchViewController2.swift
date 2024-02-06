//
//  SearchViewController2.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/29/24.
//

import UIKit

//class SearchViewController2: UIViewController, ConfigurableView {
//    
//    let searchBar = UISearchBar()
//    let searchTableView = UITableView()
//    let recentSearchLabel = UILabel()
//    let deleteAllKeywordButton = UIButton()
//    let emptyView = UIView()
//    let emptyImageView = UIView()
//    let emptyViewLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//    }
//
//    func configureHierarchy() {
//        <#code#>
//    }
//    
//    func configureLayout() {
//        <#code#>
//    }
//    
//    func configureView() {
//        view.configureStyle(backgroundColor: .black)
//        
//        
//        
//        searchBar.barTintColor = .backgroundColor
//        searchBar.searchTextField.backgroundColor = .veryDarkColor
//        searchBar.searchTextField.tintColor = .pointColor
//        searchBar.searchTextField.leftView?.tintColor = .systemGray
//        searchBar.searchTextField.textColor = .textColor
//        
//        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
//        
//        recentSearchLabel.text = "최근 검색"
//        recentSearchLabel.textColor = .textColor
//        recentSearchLabel.font = .customFont(.secondaryBoldTitle)
//        
//        deleteAllKeywordButton.setTitle("모두 지우기", for: .normal)
//        deleteAllKeywordButton.layer.borderColor = UIColor.white.cgColor
//        deleteAllKeywordButton.changeFont(font: .customFont(.secondaryBoldTitle))
//        
//        deleteAllKeywordButton.tintColor = .pointColor
//        
//        emptyView.backgroundColor = .backgroundColor
//        emptyImageView.image = UIImage(named: "empty")
//        
//        emptyViewLabel.text = "최근 검색어가 없어요"
//        emptyViewLabel.textAlignment = .center
//        emptyViewLabel.font = .customFont(.primaryBoldTitle)
//        emptyViewLabel.textColor = .white
//        
//        appearingView(isRecentKeywordEmpty: searchedKeywords.isEmpty)
//    }
//}
//
//extension ConfigurableView {
//    
//    
//    
//}
