//
//  ImageViewTvCell.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 15/06/22.
//

import UIKit

class ImageViewTvCell: UITableViewCell {

    @IBOutlet weak var previewImgView: UIImageView!
    static let cellIdentifier = "ImageViewTvCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
