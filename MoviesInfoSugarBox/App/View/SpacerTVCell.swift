//
//  SpacerTVCell.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

class SpacerCellModel : CellModelProtocol {
    var reusableIdentifier: String = SpacerTVCell.identifier
    
    var height: CGFloat = UITableView.automaticDimension
    
    var estimatedhHeight: CGFloat = 10
    
    var leftPadding : CGFloat = 0
    var rightPadding : CGFloat = 0
    var backgroundColor: UIColor
    init(gridHeight : CGFloat = 1, backgroundColor: UIColor = UIColor.white , leadingGridSpacing : CGFloat = 0, trailingGridSpacing : CGFloat = 0) {
        self.backgroundColor = backgroundColor
        self.leftPadding = leadingGridSpacing
        self.rightPadding = trailingGridSpacing
    }
}

class SpacerTVCell: UITableViewCell, ConfigurableView {
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ cellModel: CellModelProtocol) {
        let model = (cellModel as? SpacerCellModel)
        heightConstraint.constant = model?.height ?? 1
        
        leftPadding.constant = model?.leftPadding ?? 0
        rightPadding.constant = model?.rightPadding ?? 0
        
        self.backgroundColor = model?.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
