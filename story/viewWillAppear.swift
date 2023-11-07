//
//  ViewController.swift
//  story
//
//  Created by 郭芳廷 on 2023/6/13.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var myButtonIsSelect: Bool = false
    var mail: String = ""
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
    }
}
