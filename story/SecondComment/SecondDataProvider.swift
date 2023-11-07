//
//  SecondDataProvider.swift
//  story
//
//  Created by 李彤 on 2023/9/5.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class SecondDataProvider: NSObject {
    var db: Firestore!
    var seconduserproducts:[SecondInformation] = []
    
    func loadsecondData(){
        seconduserproducts = [SecondInformation]()
                
        db = Firestore.firestore()
        
        print("BB")
        print(UserArrary_name, UserArrary_date, UserArrary_comment, UserArrary_score)

        if(UserArrary_name.isEmpty == false && UserArrary_date.isEmpty == false && UserArrary_comment.isEmpty == false && UserArrary_score.isEmpty == false && UserArray_mail.isEmpty == false){
            print("CC")
            print(UserArrary_name, UserArrary_date, UserArrary_comment, UserArrary_score)
            for i in 0...UserArrary_name.count-1{
                let user2 = SecondInformation(Usdate: UserArrary_date[i], Usname: UserArrary_name[i], UsimgName: UserArray_mail[i], Uscomment: UserArrary_comment[i], Usscore: UserArrary_score[i])
                seconduserproducts.append(user2)
            }
        }

        UserArrary_name.removeAll()
        UserArrary_date.removeAll()
        UserArrary_comment.removeAll()
        UserArrary_score.removeAll()
        UserArray_mail.removeAll()
    }
}
