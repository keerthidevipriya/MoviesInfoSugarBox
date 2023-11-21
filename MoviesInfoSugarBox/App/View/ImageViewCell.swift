//
//  ImageViewCell.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

class ImageViewCellModel: CellModelProtocol {
    var reusableIdentifier: String  = ImageViewCell.identifier
    var height: CGFloat = UITableView.automaticDimension
    var estimatedhHeight: CGFloat = 100
    
    var image: String
    
    init(image: String) {
        self.image = image
    }
}

class ImageViewCell: UITableViewCell, ConfigurableView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ cellModel: CellModelProtocol) {}
}

