//
//  Acomment.swift
//  story
//
//  Created by 李彤 on 2023/8/29.
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

var UserdataArrary_name: [String] = []
var UserdataArrary_comment: [String] = []
var UserdataArrary_date: [String] = []
var UserdataArrary_score: [String] = []
var UserdataArray_mail: [String] = []

class Acomment: NSObject {
    var db: Firestore!
    
    func loadAcomment(){
        db = Firestore.firestore()

        db.collection("AllProducts").document(n).collection("main").order(by: "TIMER", descending: true).getDocuments { snapshot, error in
            guard let snapshot else { return }
            snapshot.documents.forEach { snapshot in
                UserdataArrary_name.append((snapshot.data()["UserName"] ?? "") as! String)
                UserdataArrary_date.append((snapshot.data()["DATE"] ?? "") as! String)
                UserdataArrary_comment.append((snapshot.data()["main_comment"] ?? "") as! String)
                UserdataArray_mail.append((snapshot.data()["USER"] ?? "") as! String)
                UserdataArrary_score.append((snapshot.data()["userscore"] ?? "") as! String)
            }
        }
    }
}
