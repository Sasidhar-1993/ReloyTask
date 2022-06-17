//
//  PreviewViewController.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation
import UIKit
import Kingfisher



class PreviewViewController : UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var previewTableView: UITableView!
    
    var booldd = false
    
    var hitModel: Hit?
    var previewViewModel = PreviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewViewModel.createModelData(hitModel: hitModel)
        
        previewTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        previewTableView.estimatedRowHeight = 50
        previewTableView.dataSource = self
        previewTableView.delegate = self
        
    }
    
}

extension PreviewViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previewViewModel.imageModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = previewViewModel.imageModelArray[indexPath.row]
        
        switch model.typeMode {
            
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier:ImageViewTvCell.cellIdentifier , for: indexPath) as! ImageViewTvCell
            let urlStr = model.desc
            if let url = URL(string: urlStr ?? "") {
                cell.previewImgView.kf.setImage(with: url)
            }
            return cell
            
        case .text:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell?
            cell?.textLabel?.text = model.desc
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
