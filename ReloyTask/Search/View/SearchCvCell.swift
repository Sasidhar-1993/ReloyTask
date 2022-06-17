//
//  SearchCvCell.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import UIKit

class SearchCvCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    static let cellIdentifier = "SearchCvCell"
    
    var hit : Hit? = nil {
        didSet{
            imgView.backgroundColor = .red
            imgView.layer.cornerRadius = 5.0
            
            let urlStr = hit?.previewURL ?? ""
            if let url = URL(string: urlStr) {
                imgView.layer.cornerRadius = 5.0
                imgView.kf.setImage(with: url)
                imgView.kf.indicatorType = .activity
            }
            
            if let isSelected = hit?.isSelected,
               isSelected == true {
                imgView.layer.borderColor = UIColor.green.cgColor
                imgView.layer.borderWidth = 5.0
            }else{
                imgView.layer.borderWidth = 0.0
            }
        }
    }
    
    
}
