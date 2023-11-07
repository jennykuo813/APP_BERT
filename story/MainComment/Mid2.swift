//
//  Mid2.swift
//  story
//
//  Created by 李彤 on 2023/9/4.
//

import UIKit

var nn = String()
var ss = String()
var cc = String()
var mm = String()
var dd = String()

class Mid2: UIViewController {
    
    var Acomments: UserProduct?

    @IBOutlet weak var Prscore: UITextField!
    @IBOutlet weak var USERname: UITextField!
    @IBOutlet weak var USERcomment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let commentObj = Acomments {
            Prscore.text = commentObj.Uscore
            USERname.text = commentObj.Uname
            USERcomment.text = "comments :  " + commentObj.Ucomment
            
            nn = commentObj.Uname
            ss = commentObj.Uscore
            cc = commentObj.Ucomment
            mm = commentObj.UimgName
            dd = commentObj.Udate
            Bcomment().loadBcomment()
            navigationItem.setHidesBackButton(true, animated: false)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false){ timer in
            self.performSegue (withIdentifier: "showcomments", sender: self)
        }
    }
}

