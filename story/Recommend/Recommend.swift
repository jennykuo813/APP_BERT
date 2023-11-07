//
//  Recommend.swift
//  story
//
//  Created by 李彤 on 2023/9/27.
//

import UIKit

class Recommend: NSObject {
    var StarImg: String
    var StarScore: String
    var StarName: String
    var StarRank: String
    
    init(StarImg: String, StarScore: String, StarName: String, StarRank: String) {
        self.StarImg = StarImg
        self.StarScore = StarScore
        self.StarName = StarName
        self.StarRank = StarRank
    }
}

