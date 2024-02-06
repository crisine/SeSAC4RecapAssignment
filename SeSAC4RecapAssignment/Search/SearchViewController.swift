//
//  SearchViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var recentSearchLabel: UILabel!
    @IBOutlet weak var deleteAllKeywordButton: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    let username = UserDefaults.standard.string(forKey: "username")
    var searchedKeywords = RecentSearch.keywords {
        didSet {
            RecentSearch.keywords = searchedKeywords
            
            appearingView(isRecentKeywordEmpty: searchedKeywords.isEmpty)
            
            UserDefaults.standard.setValue(searchedKeywords, forKey: "searchedKeywords")
            
            searchTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        configureView()
        configureNavigation()
        configureTableView()
    }
    
    func appearingView(isRecentKeywordEmpty: Bool) {
        switch isRecentKeywordEmpty {
        case true:
            emptyView.isHidden = false
            recentSearchLabel.isHidden = true
            deleteAllKeywordButton.isHidden = true
        case false:
            emptyView.isHidden = true
            recentSearchLabel.isHidden = false
            deleteAllKeywordButton.isHidden = false
        }
    }
    
    func configureView() {
        view.backgroundColor = .backgroundColor
        
        searchBar.barTintColor = .backgroundColor
        searchBar.searchTextField.backgroundColor = .veryDarkColor
        searchBar.searchTextField.tintColor = .pointColor
        searchBar.searchTextField.leftView?.tintColor = .systemGray
        searchBar.searchTextField.textColor = .textColor
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.textColor = .textColor
        recentSearchLabel.font = .customFont(.secondaryBoldTitle)
        
        deleteAllKeywordButton.setTitle("모두 지우기", for: .normal)
        deleteAllKeywordButton.layer.borderColor = UIColor.white.cgColor
        deleteAllKeywordButton.changeFont(font: .customFont(.secondaryBoldTitle))
        
        deleteAllKeywordButton.tintColor = .pointColor
        
        emptyView.backgroundColor = .backgroundColor
        emptyImageView.image = UIImage(named: "empty")
        
        emptyViewLabel.text = "최근 검색어가 없어요"
        emptyViewLabel.textAlignment = .center
        emptyViewLabel.font = .customFont(.primaryBoldTitle)
        emptyViewLabel.textColor = .white
        
        appearingView(isRecentKeywordEmpty: searchedKeywords.isEmpty)
    }
    
    func configureNavigation() {
        
        navigationItem.title = "\(username ?? "default")님의 새싹쇼핑"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.textColor,
                                                                   NSAttributedString.Key.font: UIFont.customFont(.primaryBoldTitle)]
    }
    
    
    @IBAction func didDeleteAllKeywordButtonTapped(_ sender: UIButton) {
        searchedKeywords.removeAll()
        searchTableView.reloadData()
    }
    
    func moveToSearchResultView(keyword: String, start: Int, sortType: ItemSortType) {
        
        let sb = UIStoryboard(name: "SearchResult", bundle: nil)
        let vc = sb.instantiateViewController(identifier: SearchResultViewController.identifier) as! SearchResultViewController
        
        vc.keyword = keyword
        vc.start = start
        vc.sortType = sortType
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchBar.text?.lowercased() else { return }
        
        dismissKeyboard()
        
        updateSearchedKeywords(keyword: keyword)
        moveToSearchResultView(keyword: keyword, start: 1, sortType: .sim)
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func updateSearchedKeywords(keyword: String) {
        if searchedKeywords.contains(keyword) {
            searchedKeywords.remove(at: searchedKeywords.firstIndex(of: keyword)!)
        }
        searchedKeywords.insert(keyword, at: 0)
    }
}

extension SearchViewController: UITableViewDelegate,
                                UITableViewDataSource {
    
    func configureTableView() {
        searchTableView.backgroundColor = .backgroundColor
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedKeywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        let index = indexPath.row
        
        cell.configureCell(keyword: searchedKeywords[index])
        
        cell.index = index
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        searchBar.searchTextField.text = ""
        let keyword = searchedKeywords[indexPath.row]
        
        updateSearchedKeywords(keyword: keyword)
        moveToSearchResultView(keyword: keyword, start: 1, sortType: .sim)
    }
}

extension SearchViewController: ButtonTappedDelegate {
    func cellButtonTapped(index: Int) {
        searchedKeywords.remove(at: index)
    }
}
