//
//  Bcomment.swift
//  story
//
//  Created by 李彤 on 2023/9/4.
//

import UIKit
import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

var UserArrary_name: [String] = []
var UserArrary_comment: [String] = []
var UserArrary_date: [String] = []
var UserArrary_score: [String] = []
var UserArray_mail: [String] = []

class Bcomment: NSObject {
    var db: Firestore!
    
    func loadBcomment(){
        db = Firestore.firestore()
        db.collection("AllProducts").document(n).collection("main").document(mm).collection("second").order(by: "TIMER", descending: true).getDocuments { snapshot, error in
            guard let snapshot else { return }
            snapshot.documents.forEach { snapshot in
                UserArrary_name.append((snapshot.data()["UserName"] ?? "") as! String)
                UserArrary_date.append((snapshot.data()["DATE"] ?? "") as! String)
                UserArrary_comment.append((snapshot.data()["aux_comment"] ?? "") as! String)
                UserArrary_score.append((snapshot.data()["userscore"] ?? "") as! String)
                UserArray_mail.append((snapshot.data()["USER"] ?? "") as! String)
            }
            print("AA")
            print(UserdataArrary_name, UserdataArrary_date, UserdataArrary_comment, UserdataArrary_score)
        }
    }
}
