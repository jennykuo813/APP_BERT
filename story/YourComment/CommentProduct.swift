//
//  CommentProduct.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/21.
//

import Foundation
import UIKit

class CommentProduct: NSObject {
    var Cdate: String
    var Cname: String
    var Ccom: String
    var CimgName: String
    var Cuser: String
    
    init(Cdate: String, Cname: String, Ccom: String, CimgName: String, Cuser: String) {
        self.Cdate = Cdate
        self.Cname = Cname
        self.Ccom = Ccom
        self.CimgName = CimgName
        self.Cuser = Cuser
    }

}
