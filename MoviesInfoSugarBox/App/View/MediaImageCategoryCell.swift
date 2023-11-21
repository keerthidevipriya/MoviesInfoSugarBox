//
//  MediaImageCategoryCell.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit
import SDWebImage

class MediaImageCategoryCell: CaraouselCVCellModel {
    func sizeForItemIn(collectionView: UICollectionView) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 160)
    }
    
    var reusableIdentifier: String = MediaImageCollectionViewCell.identifier
    
    var height: CGFloat = 160
    
    var estimatedhHeight: CGFloat = 160
    
    var imageUrlString: String
    init(image: String) {
        let baseUrl = "https://static01.sboxdc.com/images"
        self.imageUrlString = baseUrl + image
    }
}

extension MediaImageCategoryCell : CaraousalCVCellAdjustable {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


class MediaImageCollectionViewCell: UICollectionViewCell, ConfigurableView {
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)

            contentView.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func configure(_ cellModel: CellModelProtocol) {
        guard let cellModel = cellModel as? MediaImageCategoryCell else { return }
        if let url = URL(string: cellModel.imageUrlString) {
            self.imageView.sd_setImage(with: url, completed: nil)
        }
    }
}
