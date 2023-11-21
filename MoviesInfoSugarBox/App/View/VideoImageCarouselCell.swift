//
//  VideoImageCarouselCell.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit
import AVFoundation
import SDWebImage
import AVKit
import SkeletonView

enum NotificationIdentifier : String {
    case stopShimmerEffect = "stopShimmerEffect"
    case startShimmerEffect = "startShimmerEffect"
    
    public var name:Notification.Name {
        let name:Notification.Name
        switch self {
        default:
            name = Notification.Name(rawValue: self.rawValue)
        }
        return name
    }
}

let collectionViewHeight: CGFloat = collectionViewWidth * 9 / 16
let collectionViewWidth: CGFloat = 220

class VideoImageCVCCellModel: CaraouselCVCellModel {
    func sizeForItemIn(collectionView: UICollectionView) -> CGSize {
        let mainCarouselViewWidth: CGFloat = collectionView.frame.width
        let mainCarouselViewHeight: CGFloat = mainCarouselViewWidth * 9 / 16 + 50
        if isMainCarousel {
            return CGSize.init(width: mainCarouselViewWidth - 30, height: mainCarouselViewHeight)
        }
        return CGSize.init(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    var reusableIdentifier: String = VideoImageCarouselCell.identifier
    
    var height: CGFloat = collectionViewHeight
    
    var estimatedhHeight: CGFloat = collectionViewHeight
    
    var imageUrlString: String
    var thumbnailUrlString: String
    var isMainCarousel = false
    init(image: String, thumbnail: String, isMainCarousel: Bool = false) {
        let baseUrl = "https://static01.sboxdc.com/images"
        self.imageUrlString = baseUrl + image
        self.thumbnailUrlString = baseUrl + image
        self.isMainCarousel = isMainCarousel
        height = isMainCarousel ? 300 : collectionViewHeight
    }
    
    
}

extension VideoImageCVCCellModel : CaraousalCVCellAdjustable {
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

class VideoImageCarouselCell: UICollectionViewCell, ConfigurableView {
    

    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    weak var shimmerView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoImageView.contentMode = .scaleAspectFit
        videoImageView.layer.cornerRadius =  10
        videoImageView.layer.masksToBounds = true
    }
    
    @objc func startShimmering() {
        mediaView.isHidden = false
        mediaView.showAnimatedSkeleton(usingColor: UIColor.init(hex: 0x808080), animation: nil, transition: .crossDissolve(0.5))
    }
    
    @objc func stopShimmeringEffect() {
        self.mediaView.hideSkeleton()
        mediaView.backgroundColor = .clear
        self.mediaView.isHidden = true
    }
    
    func configure(_ cellModel: CellModelProtocol) {
        guard let cellModel = cellModel as? VideoImageCVCCellModel, let mediaURL = URL(string: cellModel.imageUrlString) else {
            return
        }
        let pathExtension = mediaURL.pathExtension.lowercased()
        if pathExtension == "jpg" || pathExtension == "jpeg" || pathExtension == "png" {
            if let url = URL(string: cellModel.thumbnailUrlString) {
                self.videoImageView.sd_setImage(with: url, completed: nil)
                self.videoImageView.sd_setImage(with: url) { image, error, cache, url in
                    if error == nil {
                        self.videoImageView.sd_setImage(with: mediaURL, completed: nil)
                    }
                }
            } else {
                self.videoImageView.sd_setImage(with: mediaURL, completed: nil)
            }
        }  else if pathExtension == "m3u8" {
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = AVPlayer(url: mediaURL)
            videoPlayer.view.frame = mediaView.bounds
            mediaView.addSubview(videoPlayer.view)
        }
    }
}
