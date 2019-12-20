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
    func setupUI() -> Void {
        self.title = "Shopper"
        let nibName = UINib(nibName: CellName.productListCell, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: CellIdentifiers.productListCell)
        fetchData()
    }
    
    //MARK: - Network Call
    func fetchData() -> Void {
        activityIndicator.startAnimating()
        viewModel.getProductList {[unowned self] (status, error) in
            self.activityIndicator.stopAnimating()
            if status{
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }else{
                if let err = error{
                    print(err)
                }
            }
        }
    }
}

//MARK: - Extensions
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.productListCell, for: indexPath) as! ProductListTableViewCell
        cell.setupCell(cellData: viewModel.productListData[indexPath.row].getTableData())
        cell.callback = {[unowned self] in
            self.tableView.reloadData()
        }
        return cell
    }
}

