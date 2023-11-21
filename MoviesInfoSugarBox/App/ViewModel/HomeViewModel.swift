//
//  HomeViewModel.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import Foundation

class HomeViewModel: BaseViewModel {
    override func buildTableViewModels() {
        defer {
            dataSourceUpdated?()
        }
        cellModels.append(ImageViewCellModel(image: String()))
    }
}

protocol ListViewModelProtocol {
    func fetchDetailsData(page: Int, perPage: Int)
    func handlePagination(listData: ListMediaDataModel)
}

class ListViewModel: BaseViewModel, ListViewModelProtocol {
    
    var listViewData = [Datum]()
    var currentPage = 0
    var perPageData = 2
    var currentIndex: Int = 0
    var isPlaying = false
    var listMediaAllData: ListMediaDataModel?
    var pagination: Pagination?
    var isShimmerEffect = false
    
    var MediaImageCarouselTVCell : CaraouselCVCellModel!
    
    func fetchInitalData() {
        buildTableViewModels()
        fetchDetailsData(page: currentPage, perPage: perPageData)
    }
    
    func fetchNextPageData() {
        if let totalPages = pagination?.totalPages,
            currentPage < totalPages {
            fetchDetailsData(page: currentPage, perPage: perPageData)
        }
    }
    
    func fetchDetailsData(page: Int, perPage: Int) {
        let repository = ListViewRepository()
        repository.fetchHomePageData(page: page + 1, perPage: perPage) { data in
            self.isShimmerEffect = false
            self.handlePagination(listData: data)
        }
    }
    
    private func getCarouselItems(datum: Datum, isMainCarousel: Bool) -> [CaraouselCVCellModel] {
        var items: [CaraouselCVCellModel] = []
        if let contents = datum.contents {
            for conts in contents {
                var sourcePath  = String()
                var thumbNail = String()
                if let _sourcePath = conts.assets?.first(where: { asset in
                    if asset.assetType == .image, asset.type == .thumbnailList {
                        return true
                    }
                    return false
                })?.sourcePath {
                    sourcePath = _sourcePath
                }
                
                if let _sourcePath = conts.assets?.first(where: { asset in
                    return asset.assetType == .image && asset.type == .thumbnail
                })?.sourcePath {
                    thumbNail = _sourcePath
                }
                if !sourcePath.isEmpty {
                    items.append(VideoImageCVCCellModel(image: sourcePath, thumbnail: thumbNail, isMainCarousel: isMainCarousel))
                }
            }
        }
        
        return items
    }
    
    private func getShimmerCarouselItems(isMainCarousel: Bool, count: Int) -> [CaraouselCVCellModel] {
        var items: [CaraouselCVCellModel] = []
        
        for _ in 0..<count {
            items.append(VideoImageCVCCellModel(image: String(), thumbnail: String(), isMainCarousel: isMainCarousel))
        }
        return items
    }
    
    func handlePagination(listData: ListMediaDataModel) {
        if let data = listData.data {
            self.listViewData.append(contentsOf: data)
            if self.listViewData.count == data.count {
                buildTableViewModels()
            } else {
                self.updateCellModels(listData: data)
            }
        }
        if let currentPage = listData.pagination?.currentPage {
            self.currentPage = currentPage
        }
        if let perPage = listData.pagination?.perPage {
            self.perPageData = perPage
        }
        pagination = listData.pagination
        
    }
    
    func updateCellModels(listData: [Datum]) {
        defer {
            self.dataSourceUpdated?()
        }
        for datum in listData {
            if let title = datum.title {
                if let designSlug = datum.designSlug, designSlug == "CarousalWidget" {
                    let items = self.getCarouselItems(datum: datum, isMainCarousel: true)
                    cellModels.append(NBCarouselTVCellModel(isMainCarousel: true, items: items))
                } else {
                    cellModels.append(ListTitleCellModel(title: title))
                    let items = self.getCarouselItems(datum: datum, isMainCarousel: false)
                    cellModels.append(NBCarouselTVCellModel(items: items))
                }
            }
        }
    }
    
    override func buildTableViewModels() {
        defer {
            self.dataSourceUpdated?()
        }
        
        cellModels.removeAll()
        
        cellModels.append(MainTitleCellModel(title: "Sugar Box"))
        cellModels.append(SpacerCellModel())
        
        if isShimmerEffect {
            for index in 0..<4 {
                if index == 0 {
                    let items = self.getShimmerCarouselItems(isMainCarousel: false, count: 4)
                    cellModels.append(NBCarouselTVCellModel(isShimmerEffect: isShimmerEffect, isMainCarousel: true, items: items))
                } else {
                    let items = self.getShimmerCarouselItems(isMainCarousel: false, count: 4)
                    cellModels.append(NBCarouselTVCellModel(isShimmerEffect: isShimmerEffect, items: items))
                }
            }
        } else {
            for datum in listViewData {
                if let title = datum.title {
                    if let designSlug = datum.designSlug, designSlug == "CarousalWidget" {
                        let items = self.getCarouselItems(datum: datum, isMainCarousel: true)
                        cellModels.append(NBCarouselTVCellModel(isMainCarousel: true, items: items))
                    } else {
                        cellModels.append(ListTitleCellModel(title: title))
                        let items = self.getCarouselItems(datum: datum, isMainCarousel: false)
                        cellModels.append(NBCarouselTVCellModel(items: items))
                    }
                }
            }
        }
        
    }
}
