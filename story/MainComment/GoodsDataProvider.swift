//
//  GoodsDataProvider.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class GoodsDataProvider: NSObject {
    
    var db: Firestore!
    var userproducts:[UserProduct] = []
    
    func loadgoodsData(){
        userproducts = [UserProduct]()
                
        db = Firestore.firestore()

        if(UserdataArrary_name.isEmpty == false && UserdataArrary_date.isEmpty == false && UserdataArrary_comment.isEmpty == false && UserdataArrary_score.isEmpty == false && UserdataArray_mail.isEmpty == false){
            for i in 0...UserdataArrary_name.count-1{
                let user = UserProduct(Udate: UserdataArrary_date[i], Uname: UserdataArrary_name[i], UimgName: UserdataArray_mail[i], Ucomment: UserdataArrary_comment[i], Uscore: UserdataArrary_score[i])
                userproducts.append(user)
            }
        }

        UserdataArrary_date.removeAll()
        UserdataArrary_name.removeAll()
        UserdataArrary_comment.removeAll()
        UserdataArrary_score.removeAll()
        UserdataArray_mail.removeAll()
    }
}
