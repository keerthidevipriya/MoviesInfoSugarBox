//
//  HomePageApi.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import Foundation

protocol ListViewRepositoryProtocol {
    func fetchHomePageData(page: Int, perPage: Int, completionHandler: @escaping (ListMediaDataModel) -> Void)
}

class ListViewRepository: ListViewRepositoryProtocol {
    var detailsEndPoint = "/v2/super/feeds/zee5-home/details"
    var networkManger: NetworkManager
    let url = "https://apigw.sboxdc.com/ecm"
    init() {
        self.networkManger = NetworkManager(baseUrl: url)
    }
    
    func fetchHomePageData(page: Int, perPage: Int, completionHandler: @escaping (ListMediaDataModel) -> Void) {
        detailsEndPoint += "?page=\(page)&perPage=\(perPage)"
        
        networkManger.fetchData(from: detailsEndPoint, method: .get) { [weak self] (result: Result<ListMediaDataModel, Error>) in
            switch result {
            case .success(let data):
                return completionHandler(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
