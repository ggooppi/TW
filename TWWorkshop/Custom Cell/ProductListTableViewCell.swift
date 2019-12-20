//
//  ProductListTableViewCell.swift
//  TWWorkshop
//
//  Created by gopinath.a on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var wishListCount: UILabel!
    
    var productID = ""
    var callback: (() -> Void)?
    
    private var valueObservation: NSKeyValueObservation!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImageView.isHidden = true
        activityIndicator.color = UIColor.purple
        plusButton.roundedCorners(radius: plusButton.bounds.height / 2)
        minusButton.roundedCorners(radius: minusButton.bounds.height / 2)
        
        valueObservation = productImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.activityIndicator.stopAnimating()
                self.productImageView.isHidden = false
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusButtonONClick(_ sender: Any) {
        let value = UserDefaults.standard.integer(forKey: productID)
        UserDefaults.standard.set(value + 1, forKey: productID)
        if let callBack = self.callback{
            callBack()
        }
    }
    
    @IBAction func minusButtonOnClick(_ sender: Any) {
        let value = UserDefaults.standard.integer(forKey: productID)
        if value != 0{
            UserDefaults.standard.set(value - 1, forKey: productID)
            if let callBack = self.callback{
                callBack()
            }
        }
    }
    
    func setupCell(cellData: ShopperList.ListTableData) -> Void {
        productID = cellData.id
        titleLabel.text = cellData.title
        detailLabel.text = cellData.des
        detailLabel.textColor = cellData.desColor
        let value = UserDefaults.standard.integer(forKey: productID)
        if value != 0{
            wishListCount.isHidden = false
            wishListCount.text = "(\(value))"
        }else{
            wishListCount.isHidden = true
            wishListCount.text = "(\(value))"
        }
        Webservice.shared.getImageFrom(url: cellData.image, for: productImageView)
    }
    
}
