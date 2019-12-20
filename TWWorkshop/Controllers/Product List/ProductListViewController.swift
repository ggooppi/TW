//
//  ViewController.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductListViewController: UIViewController {
    
    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = ProductListViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK: -UI Function
    private func setupUI() -> Void {
        self.title = "Shopper"
        viewModel.dataSource = self
        let nibName = UINib(nibName: CellName.productListCell, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: CellIdentifiers.productListCell)
        fetchData()
    }
    
    //MARK: - Network Call
    private func fetchData() -> Void {
        activityIndicator.startAnimating()
        viewModel.getProductList()
    }
}

//MARK: - Extensions
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.productListCell, for: indexPath) as! ProductListTableViewCell
        cell.setupCell(cellData: viewModel.getCellDataFor(product: viewModel.productListData[indexPath.row]))
        cell.callback = { [unowned self] event in
            self.viewModel.updateWishist(for: self.viewModel.productListData[indexPath.row].pid, eventType: event)
            self.tableView.reloadData()
        }
        return cell
    }
    
}

extension ProductListViewController: NetworkCallHandler{
    
    func dataFetched() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    func failedToFetchData(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
    
}

