//
//  CommentTableViewCell.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/21.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell{
    
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var commentTo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
