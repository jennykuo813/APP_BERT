//
//  SecondTableViewCell.swift
//  story
//
//  Created by 李彤 on 2023/9/5.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CommentDate2: UILabel!
    @IBOutlet weak var UserScore2: UILabel!
    @IBOutlet weak var UserComment2: UILabel!
    @IBOutlet weak var UserName2: UILabel!
    @IBOutlet weak var UserImg2: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
