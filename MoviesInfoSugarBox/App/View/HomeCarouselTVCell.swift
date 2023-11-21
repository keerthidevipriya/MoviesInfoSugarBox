//
//  HomeCarouselTVCell.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

var tag = 9999

protocol CaraouselCVCellModel: CellModelProtocol {
    func sizeForItemIn(collectionView: UICollectionView)-> CGSize
}

protocol CaraousalCVCellAdjustable : AnyObject  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
}

class NBCarouselTVCellModel: CellModelProtocol {
    
    var items: [CaraouselCVCellModel] = []
    var itemHeight: CGFloat = collectionViewHeight
    
    var autoScroll : Bool = false
    var autoScrolling : Bool = false
    let pagingEnabled : Bool
    var scrollingCallback:(() -> Void)?
    var isPageContolHidden: Bool
    
    var removeObserver : Bool = false
    
    var reusableIdentifier: String  = NBCarouselTVCell.identifier
    var height: CGFloat = UITableView.automaticDimension
    var estimatedhHeight: CGFloat = 160
    var isMainCarousel = false
    var isShimmerEffect = false
    
    init(isShimmerEffect : Bool = false, isMainCarousel : Bool = false, itemHeight: CGFloat = 1, items: [CaraouselCVCellModel] = [], pagingEnabled : Bool = false, isPageContolHidden: Bool = false, scrollingCallback:(() -> Void)? = nil) {
        self.items = items
        self.isShimmerEffect = isShimmerEffect
        self.pagingEnabled = pagingEnabled
        self.scrollingCallback = scrollingCallback
        self.isPageContolHidden = isPageContolHidden
        self.itemHeight = isMainCarousel ? 300 : collectionViewHeight
    }
    
    func numberOfItems()-> Int{
        return items.count
    }
}


class NBCarouselTVCell: UITableViewCell, ConfigurableView {
   
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var model: NBCarouselTVCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(_ cellModel: CellModelProtocol) {
        guard let model = cellModel as? NBCarouselTVCellModel else {
            return
        }
        self.model = model
        self.collectionViewHeight.constant =  model.itemHeight
        self.collectionView.reloadData()
        
        if model.isShimmerEffect {
            NotificationCenter.default.post(name: NotificationIdentifier.startShimmerEffect.name, object: nil)
        } else {
            NotificationCenter.default.post(name: NotificationIdentifier.stopShimmerEffect.name, object: nil)
        }
    }
    
    func setupView() {
        self.tag = tag
        tag += 1
        collectionView.register(VideoImageCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension NBCarouselTVCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension NBCarouselTVCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.numberOfItems() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = model else {
            return UICollectionViewCell.init()
        }
        let item = model.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell_(withIdentifier: item.reusableIdentifier, for: indexPath)
        if let _cell = cell as? ConfigurableView {
            _cell.configure(item)
        }
        return cell
    }
}


extension NBCarouselTVCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = model else {
            return CGSize.zero
        }
        return model.items[indexPath.row].sizeForItemIn(collectionView: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let model = model else {
            return UIEdgeInsets.zero
        }
        return (model.items.first as? CaraousalCVCellAdjustable)?.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section) ?? UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (model?.items.first as? CaraousalCVCellAdjustable)?.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (model?.items.first as? CaraousalCVCellAdjustable)?.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) ?? 0
    }
}

