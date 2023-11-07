//
//  NewTableViewCell.swift
//  story
//
//  Created by 李彤 on 2023/8/15.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var newImg: UIImageView!
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newName: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
