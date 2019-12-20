//
//  ViewController.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.reloadData()
    }
    
    
}

//MARK: - Extensions
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getData().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var defaultCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.defaultCell)
        
        if defaultCell == nil {
            defaultCell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifiers.defaultCell)
            defaultCell!.selectionStyle = .none
            defaultCell!.textLabel?.font = UIFont.systemFont(ofSize: 17)
            defaultCell!.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            defaultCell!.textLabel?.numberOfLines = 0
            defaultCell!.detailTextLabel?.numberOfLines = 0
            defaultCell!.detailTextLabel?.textColor = UIColor.gray
        }
        if let cell = defaultCell{
            cell.textLabel?.text = viewModel.getData()[indexPath.row].name
//            if let price = viewModel.getData()[indexPath.row].offerPrice, price != ""{
//                cell.detailTextLabel?.text = price
//                cell.detailTextLabel?.textColor = UIColor.red
//            }else{
//                cell.detailTextLabel?.text = viewModel.getData()[indexPath.row].price
//            }
            return cell
        }
        return UITableViewCell()
    }
}

