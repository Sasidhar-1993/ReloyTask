//
//  BaseController.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 17/06/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    let searchController = UISearchController()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "search photos"
        searchController.hidesNavigationBarDuringPresentation = false
        
    }
    
    func startActivityIndicator() {
        
//        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
        actInd.color = .black
        actInd.center = view.center
        actInd.style =
        UIActivityIndicatorView.Style.large
        view.addSubview(actInd)
        actInd.startAnimating()
        
    }
    func stopActivityIndicator() {
        view.addSubview(actInd)
        actInd.stopAnimating()
    }
}
