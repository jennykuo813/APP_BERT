//
//  StarTableViewCell.swift
//  story
//
//  Created by 李彤 on 2023/9/27.
//

import UIKit

class StarTableViewCell: UITableViewCell {

    @IBOutlet weak var StarProductRank: UIImageView!
    @IBOutlet weak var StarProductScore: UIImageView!
    @IBOutlet weak var StarProductName: UILabel!
    @IBOutlet weak var StarProductImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
