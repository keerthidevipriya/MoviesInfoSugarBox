//
//  MainTitleCell.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

class MainTitleCellModel: CellModelProtocol {
    var reusableIdentifier: String  = MainTitleCell.identifier
    var height: CGFloat = UITableView.automaticDimension
    var estimatedhHeight: CGFloat = 100
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

class MainTitleCell: UITableViewCell, ConfigurableView {
    @IBOutlet weak var titleLabel: UILabel!
    func configure(_ cellModel: CellModelProtocol) {
        if let cellModel = cellModel as? ListTitleCellModel {
            titleLabel.text = cellModel.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

