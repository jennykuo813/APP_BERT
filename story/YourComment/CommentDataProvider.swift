//
//  CommentDataProvider.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

var CommentdataArrary_date: [String] = []
var CommentdataArrary_name: [String] = []
var CommentdataArrary: [String] = []
var CommentdataArrary_user: [String] = []

class CommentDataProvider: NSObject {
    
    var db: Firestore!
    var commentproducts:[CommentProduct] = []
    
    func loadCommentData(){
        commentproducts = [CommentProduct]()
                
        db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            db.collection("main_comment").whereField("USER", isEqualTo: "\(user.email!)").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    CommentdataArrary_name.append((snapshot.data()["GoodsName"] ?? "") as! String)
                    CommentdataArrary_date.append((snapshot.data()["DATE"] ?? "") as! String)
                    CommentdataArrary.append((snapshot.data()["main_comment"] ?? "") as! String)
                    CommentdataArrary_user.append((snapshot.data()["ReplyTo"] ?? "") as! String)
                }
            }
            db.collection("second_comment").whereField("USER", isEqualTo: "\(user.email!)").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    CommentdataArrary_name.append((snapshot.data()["GoodsName"] ?? "") as! String)
                    CommentdataArrary_date.append((snapshot.data()["DATE"] ?? "") as! String)
                    CommentdataArrary.append((snapshot.data()["aux_comment"] ?? "") as! String)
                    CommentdataArrary_user.append((snapshot.data()["ReplyTo"] ?? "") as! String)
                }
            }
        }
        
        if(CommentdataArrary_name.isEmpty == false){
            for i in 0...CommentdataArrary_name.count-1{
                let comm = CommentProduct(Cdate: CommentdataArrary_date[i], Cname: CommentdataArrary_name[i], Ccom: CommentdataArrary[i], CimgName: CommentdataArrary_name[i], Cuser: CommentdataArrary_user[i])
                commentproducts.append(comm)
            }
        }
        CommentdataArrary_date.removeAll()
        CommentdataArrary_name.removeAll()
        CommentdataArrary.removeAll()
        CommentdataArrary_user.removeAll()
    }
}
