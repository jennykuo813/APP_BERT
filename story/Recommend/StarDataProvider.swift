//
//  StarDataProvider.swift
//  story
//
//  Created by 李彤 on 2023/9/27.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

var starnameArrary: [String] = []
var starscoreArrary: [String] = []
var starrankArrary: [Int] = []


class StarDataProvider: NSObject {
    var starproducts:[Recommend] = []
    var db: Firestore!
    func loadStarData(){
        starproducts = [Recommend]()
        db = Firestore.firestore()
        
        db.collection("AllProducts").order(by: "rank", descending: false).limit(to: 10).getDocuments { snapshot, error in
            guard let snapshot else { return }
            snapshot.documents.forEach { snapshot in
                starnameArrary.append((snapshot.data()["name"] ?? "") as! String)
                starscoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                starrankArrary.append((snapshot.data()["rank"] ?? "") as! Int)
            }
        }
        if(starnameArrary.isEmpty == false){
            for i in 0...starnameArrary.count-1{
                let sp = Recommend(StarImg: starnameArrary[i], StarScore: starscoreArrary[i], StarName: starnameArrary[i], StarRank: "C\(starrankArrary[i])")
                starproducts.append(sp)
            }
        }
        starnameArrary.removeAll()
        starscoreArrary.removeAll()
        starrankArrary.removeAll()
    }
}
