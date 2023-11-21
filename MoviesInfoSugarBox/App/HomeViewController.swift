//
//  HomeViewController.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

class HomeViewController: BaseTableViewController {
    
    override init(viewModel: BaseViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel as? ListViewModel else { return }
        viewModel.fetchInitalData()
        viewModel.dataSourceUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchMoreData = {
            viewModel.fetchNextPageData()
        }
    }
    
    override func registerTableViewCell() {
        tableView.registerCell(ImageViewCell.self)
        tableView.registerCell(HomeTitleTableViewCell.self)
        tableView.registerCell(MainTitleCell.self)
        tableView.registerCell(HomeCarouselTVCell.self)
        tableView.registerCell(SpacerTVCell.self)
        
    }

}
