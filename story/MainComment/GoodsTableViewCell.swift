//
//  GoodsTableViewCell.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/22.
//

import Foundation
import UIKit

class GoodsTableViewCell: UITableViewCell{
    
    @IBOutlet weak var CommentDate: UILabel!
    @IBOutlet weak var UserScore: UILabel!
    @IBOutlet weak var UserComment: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
