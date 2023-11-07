//
//  NewDataProvider.swift
//  story
//
//  Created by 李彤 on 2023/8/15.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

var NewdataArrary_date: [String] = []
var NewdataArrary_name: [String] = []
var NewdataArrary_price: [String] = []
var NewdataArrary_storage: [String] = []



struct ProductStatus: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let price: String
    let product_score: Int
    let unit: String
    let NimgName: String
}


class NewDataProvider: NSObject {
    
    var db: Firestore!
    var newproducts:[NewProduct] = []
    
    func loadNewData(){
        newproducts = [NewProduct]()
                
        db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            db.collection("GoodsData").whereField("USER", isEqualTo: "\(user.email!)").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    NewdataArrary_name.append((snapshot.data()["GOODS_NAME"] ?? "") as! String)
                    NewdataArrary_date.append((snapshot.data()["DATE"] ?? "") as! String)
                    NewdataArrary_price.append((snapshot.data()["PRICE"] ?? "") as! String)
                    NewdataArrary_storage.append((snapshot.data()["StorageName"] ?? "") as! String)
                }
            }
        }

        if(NewdataArrary_name.isEmpty == false){
            print(NewdataArrary_date, NewdataArrary_name, NewdataArrary_price)
            for i in 0...NewdataArrary_name.count-1{
                let newpro = NewProduct(Ndate: NewdataArrary_date[i], Nname: NewdataArrary_name[i], Nprice: NewdataArrary_price[i], NimgName: NewdataArrary_storage[i])
                newproducts.append(newpro)
            }
        }
        print(NewdataArrary_storage)
        NewdataArrary_date.removeAll()
        NewdataArrary_name.removeAll()
        NewdataArrary_price.removeAll()
        NewdataArrary_storage.removeAll()
    }
}
