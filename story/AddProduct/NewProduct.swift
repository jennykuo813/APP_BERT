//
//  NewProduct.swift
//  story
//
//  Created by 李彤 on 2023/8/15.
//

import UIKit

class NewProduct: NSObject {
    var Ndate: String
    var Nname: String
    var Nprice: String
    var NimgName: String
    
    init(Ndate: String, Nname: String, Nprice: String, NimgName: String) {
        self.Ndate = Ndate
        self.Nname = Nname
        self.Nprice = Nprice
        self.NimgName = NimgName
    }
}
