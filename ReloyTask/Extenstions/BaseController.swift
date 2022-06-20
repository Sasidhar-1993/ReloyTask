//
//  BaseController.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 17/06/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    let searchController = UISearchController()
    let actIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        // UISearchController
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "search photos"
        searchController.hidesNavigationBarDuringPresentation = false
        // Activity Indicator
        actIndicator.center = view.center
        actIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(actIndicator)

    }
    func startActivityIndicator() {
        actIndicator.startAnimating()
        
    }
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
        }
    }
}
