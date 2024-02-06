//
//  SearchResultViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/22/24.
//

import UIKit
import Alamofire

class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchResultsLabel: UILabel!
    @IBOutlet weak var sortButtonStackView: UIStackView!
    @IBOutlet var sortButtons: [UIButton]!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var keyword: String?
    var start: Int?
    var sortType: ItemSortType?
    var shoppingInfo: NaverShopModel?
    
    override func viewWillAppear(_ animated: Bool) {
        resultCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        resultCollectionView.register(xib, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.setupLayout(itemsPerLine: 2.0, height: 260)
        
        resultCollectionView.collectionViewLayout = layout
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self

        configureView()
        configureStackView()
        configureNavigation()
        configureButtons()
        configureCollectionView()
        
        if let keyword, let start, let sortType {
            request(keyword: keyword, start: start, sortType: sortType)
        }
    }
    
    func configureView() {
        view.backgroundColor = .backgroundColor
        
        searchResultsLabel.font = .customFont(.secondaryBoldTitle)
        searchResultsLabel.textColor = .pointColor
    }
    
    func configureStackView() {
        sortButtonStackView.distribution = .fillProportionally
    }
    
    func configureNavigation() {
        
        if let keyword {
            navigationItem.title = keyword
            navigationController?.navigationBar.topItem?.title = ""
        }
    }
    
    func configureButtons() {
        for index in sortButtons.indices {
            sortButtons[index].setTitle(ItemSortType(rawValue: index)?.description, for: .normal)
            sortButtons[index].tintColor = .white
            
            if index == sortType!.rawValue {
                sortButtons[index].backgroundColor = .white
                sortButtons[index].setTitleColor(.black, for: .normal)
            } else {
                sortButtons[index].backgroundColor = .black
                sortButtons[index].setTitleColor(.white, for: .normal)
            }
            
            sortButtons[index].clipsToBounds = true
            sortButtons[index].layer.cornerRadius = 8
            sortButtons[index].changeFont(font: .customFont(.primaryBoldTitle))
            
            sortButtons[index].layer.borderColor = UIColor.white.cgColor
            sortButtons[index].layer.borderWidth = 1
            
            sortButtons[index].tag = index
            
            sortButtons[index].addTarget(self, action: #selector(didSortButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc func didSortButtonTapped(sender: UIButton) {
        switch sender.tag {
        case 0...3:
            sortType = ItemSortType(rawValue: sender.tag)
        default:
            print("button tag index error (out of range: 0~3)")
            return
        }
        
        configureButtons()
        shoppingInfo = nil
        if let keyword, let start, let sortType {
            request(keyword: keyword, start: start, sortType: sortType)
        }
    }
    
    func updateCollectionViewAndLabels() {
        guard let shoppingInfo else { return }
        
        resultCollectionView.reloadData()
        searchResultsLabel.text = "\(Utils.formatStringNumberWithCommas(numberString: String(shoppingInfo.total)))개의 검색 결과"
    }
    
    func configureCollectionView() {
        resultCollectionView.backgroundColor = .backgroundColor
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let itemCount = shoppingInfo?.items.count {
            return itemCount
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        
        if let item = shoppingInfo?.items[indexPath.row] {
            DispatchQueue.main.async {
                cell.productId = item.productID
                cell.configureCell(item: item)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let itemCount = shoppingInfo?.items.count else { return }
        
        if indexPath.row > itemCount - 6 {
            start! += 30
            if let keyword, let start, let sortType {
                request(keyword: keyword, start: start, sortType: sortType)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "SearchedItemDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchedItemDetailViewController.identifier) as! SearchedItemDetailViewController
        
        guard let items = shoppingInfo?.items else { return }
        let productId = items[indexPath.row].productID
        
        vc.productId = productId
        vc.navTitle = Utils.removeHTMLTags(from: items[indexPath.row].title)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func request(keyword: String, start: Int, sortType: ItemSortType) {
        NaverShoppingSessionManager.shared.request(query: keyword, start: start, sortType: sortType) { data, error in
            
            if let data {
                self.shoppingInfo = data
                self.updateCollectionViewAndLabels()
            } else {
                dump(error)
                // MARK: 추후 Alert 처리
            }
        }
    }
}
