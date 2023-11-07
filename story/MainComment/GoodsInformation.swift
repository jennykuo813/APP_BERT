//
//  GoodsInformation.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/22.
//

import Foundation
import UIKit

class UserProduct: NSObject {
    var Udate: String
    var Uname: String
    var UimgName: String
    var Ucomment: String
    var Uscore: String
    
    init(Udate: String, Uname: String, UimgName: String, Ucomment: String, Uscore: String) {
        self.Udate = Udate
        self.Uname = Uname
        self.UimgName = UimgName
        self.Ucomment = Ucomment
        self.Uscore = Uscore
    }
}
