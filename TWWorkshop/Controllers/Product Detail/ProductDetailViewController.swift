//
//  ProductDetailViewController.swift
//  TWWorkshop
//
//  Created by gopinath.a on 21/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    let viewModel = ProductDetailViewModel()
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDes: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    private var valueObservation: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        valueObservation = productImage.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.productImage.isHidden = false
            }
        }
        
        setupUI()
        
    }
    
    func setupUI(){
        productImage.isHidden = true
        viewModel.getImagefor(productImageView: productImage)
        productTitle.text = viewModel.selectedProduct.name
        productDes.text = viewModel.selectedProduct.desc
        productPrice.text = viewModel.getPrice()
        productPrice.textColor = viewModel.getColorForPrice()
        
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
