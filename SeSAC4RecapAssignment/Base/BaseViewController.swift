//
//  BaseViewController.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
        print("Base", #function)
    }
    

    func configureHierarchy() {
        print("Base", #function)
    }
    
    func configureLayout() {
        print("Base", #function)
    }
    
    func configureView() {
        print("Base", #function)
        view.backgroundColor = .white
    }
}
