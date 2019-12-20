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
        var defaultCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.defaultCell)
        let tableData = viewModel.productListData[indexPath.row].getTableData()
        
        if defaultCell == nil {
            defaultCell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifiers.defaultCell)
            defaultCell!.selectionStyle = .none
            defaultCell!.textLabel?.font = UIFont.systemFont(ofSize: 17)
            defaultCell!.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            defaultCell!.textLabel?.numberOfLines = 0
            defaultCell!.detailTextLabel?.numberOfLines = 0
        }
        
        if let cell = defaultCell{
            cell.textLabel?.text = tableData.title
            cell.detailTextLabel?.text = tableData.des
            cell.detailTextLabel?.textColor = tableData.desColor
            if let url = URL(string: tableData.image) {
                cell.imageView?.af_setImage(withURL: url)
            }
            return cell
        }
        
        return UITableViewCell()
    }
}

