//
//  Product.swift
//  story
//
//  Created by 李彤 on 2023/7/18.
//

import UIKit

class Product: NSObject {
    var PName: String
    var PImgName: String
    var PPrice: String
    var PCapacity: String
    var PScore: String
    var Pupload: String
    var Puploadscore: String
    
    init(PName: String, PImgName: String, PPrice: String, PCapacity: String, PScore: String, Pupload: String, Puploadscore: String) {
        self.PName = PName
        self.PImgName = PImgName
        self.PPrice = PPrice
        self.PCapacity = PCapacity
        self.PScore = PScore
        self.Pupload = Pupload
        self.Puploadscore = Puploadscore
    }
}
