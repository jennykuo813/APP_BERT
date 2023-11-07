//
//  SecondInformation.swift
//  story
//
//  Created by 李彤 on 2023/9/5.
//

import UIKit

class SecondInformation: NSObject {
    var Usdate: String
    var Usname: String
    var UsimgName: String
    var Uscomment: String
    var Usscore: String
    
    init(Usdate: String, Usname: String, UsimgName: String, Uscomment: String, Usscore: String) {
        self.Usdate = Usdate
        self.Usname = Usname
        self.UsimgName = UsimgName
        self.Uscomment = Uscomment
        self.Usscore = Usscore
    }
}
