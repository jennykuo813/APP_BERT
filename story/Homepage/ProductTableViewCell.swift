//
//  ProductTableViewCell.swift
//  story
//
//  Created by 李彤 on 2023/7/18.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var uploadscore: UILabel!
    @IBOutlet weak var productupload: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
