//
//  WishlistViewController.swift
//  TWWorkshop
//
//  Created by gopinath.a on 21/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var totalSavings: UILabel!
    @IBOutlet weak var amountToBePaid: UILabel!
    
    //MARK: - Properties
    let viewmodel = ProductListViewModel.shared
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    func updateUI() {
        let dataToshow = viewmodel.processWishlistData()
        totalItems.text = "\(dataToshow.items)"
        totalSavings.text = dataToshow.totalSavings
        amountToBePaid.text = dataToshow.total
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
