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
    var callback: ((WishlistEvent) -> Void)?
    
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
        if let callBack = self.callback{
            callBack(WishlistEvent.increase)
        }
    }
    
    @IBAction func minusButtonOnClick(_ sender: Any) {
        if let callBack = self.callback{
            callBack(WishlistEvent.decrease)
        }
    }
    
    func setupCell(cellData: ProductTableCellData) -> Void {
        productID = cellData.id
        titleLabel.text = cellData.name
        detailLabel.text = cellData.price
        detailLabel.textColor = cellData.priceColor
        wishListCount.text = "(\(cellData.wishList))"
        wishListCount.isHidden = cellData.wishList == 0
        Webservice.shared.getImageFrom(url: cellData.productImage, for: productImageView)
    }
    
}
