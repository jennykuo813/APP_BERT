//
//  Mid.swift
//  story
//
//  Created by 李彤 on 2023/8/29.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


var n = String()
var s = String()
var um = String()
var i = String()
var uc = String()
var unn = String()
var uss = String()
var productscore = Float()


class Mid: UIViewController, UIImagePickerControllerDelegate {
    
    var Aproduct: Product?

    @IBOutlet weak var MuploadScore: UILabel!
    @IBOutlet weak var Muploadname: UILabel!
    @IBOutlet weak var MCapacity: UILabel!
    @IBOutlet weak var Mprice: UILabel!
    @IBOutlet weak var MName: UITextField!
    @IBOutlet weak var MScore: UIImageView!
    @IBOutlet weak var MImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let productObj = Aproduct {
            let S = Float(productObj.PScore) ?? 0
            if S - Float(Int(S)) > 0.0 {
                s = String(Float(Int(S))+0.5)
            } else {
                s = String(Int(S))
            }
            uc = productObj.PCapacity
            um = productObj.PPrice
            n = productObj.PName
            i = productObj.PImgName
            unn = productObj.Pupload
            uss = productObj.Puploadscore
            
            Muploadname.text = productObj.Pupload
            MuploadScore.text = productObj.Puploadscore
            MCapacity.text = productObj.PCapacity
            Mprice.text = productObj.PPrice
            MName.text = productObj.PName
            MScore.image = UIImage(named: s)
            
            let file = Storage.storage().reference().child("AllData/\(productObj.PName).jpg")
            file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
                self.MImg.image = UIImage(data: datas!)
            }
            Acomment().loadAcomment()
            navigationItem.setHidesBackButton(true, animated: false)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false){ timer in
            self.performSegue (withIdentifier: "showgoods", sender: self)
        }
    }

}
