//
//  BaseViewModel.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import Foundation
import UIKit

class BaseViewModel {
    var cellModels: [CellModelProtocol] = []
    var dataSourceUpdated : (()->Void)?
    var fetchMoreData : (()->Void)?
    
    init() {
//        self.cellModels = cellModels
//        self.buildTableViewModels()
    }
    
    func buildTableViewModels() {
        
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func tableView(numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell_(withIdentifier: cellModel.reusableIdentifier, for: indexPath)
//        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        (cell as? ConfigurableView)?.configure(cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellModels.count - 2 {
            fetchMoreData?()
        }
    }
}
