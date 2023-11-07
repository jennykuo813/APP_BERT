//
//  DataProvider.swift
//  story
//
//  Created by 李彤 on 2023/7/18.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

var db: Firestore!
var dataArrary: [String] = []
var priceArrary: [String] = []
var scoreArrary: [String] = []
var capacityArrary: [String] = []
var uploadArrary: [String] = []
var allArrary: [String] = []
var UscoreArrary: [String] = []

class DataProvider: NSObject {
    var products:[Product] = []
    
    func loadData(){
        
        products = [Product]()
        db = Firestore.firestore()
        
        if(num == 0 || num == 1){
            db.collection("AllProducts").order(by: "time", descending: false).getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                    priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                    scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                    capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                    uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                    UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
                }
            }
            if(dataArrary.isEmpty == false){
                for i in 0...dataArrary.count-1{
                    let ppro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(ppro)
                }
            }
            dataArrary.removeAll()
            priceArrary.removeAll()
            scoreArrary.removeAll()
            capacityArrary.removeAll()
            uploadArrary.removeAll()
            UscoreArrary.removeAll()
        }
        if(num == 2){
            db.collection("AllProducts").whereField("type", isEqualTo: "Drinks").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                    priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                    scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                    capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                    uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                    UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
                }
            }
            if(dataArrary.isEmpty == false){
                for i in 0...dataArrary.count-1{
                    let ppro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(ppro)
                }
            }
            
            dataArrary.removeAll()
            priceArrary.removeAll()
            scoreArrary.removeAll()
            capacityArrary.removeAll()
            uploadArrary.removeAll()
            UscoreArrary.removeAll()
        }
        if(num == 3){
            db.collection("AllProducts").whereField("type", isEqualTo: "Noodles").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                    priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                    scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                    capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                    uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                    UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
                }
            }
            if(dataArrary.isEmpty == false){
                for i in 0...dataArrary.count-1{
                    let ppro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(ppro)
                }
            }
            
            dataArrary.removeAll()
            priceArrary.removeAll()
            scoreArrary.removeAll()
            capacityArrary.removeAll()
            uploadArrary.removeAll()
            UscoreArrary.removeAll()
        }
        if(num == 4){
            db.collection("AllProducts").whereField("type", isEqualTo: "Rice").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                    priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                    scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                    capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                    uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                    UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
                }
            }
            if(dataArrary.isEmpty == false){
                for i in 0...dataArrary.count-1{
                    let ppro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(ppro)
                }
            }
            
            dataArrary.removeAll()
            priceArrary.removeAll()
            scoreArrary.removeAll()
            capacityArrary.removeAll()
            uploadArrary.removeAll()
            UscoreArrary.removeAll()
        }
        if(num == 5){
            db.collection("AllProducts").whereField("type", isEqualTo: "Cookies").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                    priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                    scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                    capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                    uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                    UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
                }
            }
            if(dataArrary.isEmpty == false){
                for i in 0...dataArrary.count-1{
                    let ppro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(ppro)
                }
            }
            
            dataArrary.removeAll()
            priceArrary.removeAll()
            scoreArrary.removeAll()
            capacityArrary.removeAll()
            uploadArrary.removeAll()
            UscoreArrary.removeAll()
        }
        if(num == 6){
            db.collection("AllProducts").whereField("type", isEqualTo: "Else").getDocuments { snapshot, error in
                guard let snapshot else { return }
                snapshot.documents.forEach { snapshot in
                    dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                    priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                    scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                    capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                    uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                    UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
                }
            }
            if(dataArrary.isEmpty == false){
                for i in 0...dataArrary.count-1{
                    let ppro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(ppro)
                }
            }
            
            dataArrary.removeAll()
            priceArrary.removeAll()
            scoreArrary.removeAll()
            capacityArrary.removeAll()
            uploadArrary.removeAll()
            UscoreArrary.removeAll()
            
        }
    }
    
    func loadSearchData(){
        
        products = [Product]()
        
        db = Firestore.firestore()
        print(selectedProduct)
        db.collection("AllProducts").whereField("name", isEqualTo: selectedProduct).getDocuments { snapshot, error in
            guard let snapshot else { return }
            snapshot.documents.forEach { snapshot in
                dataArrary.append((snapshot.data()["name"] ?? "") as! String)
                priceArrary.append((snapshot.data()["price"] ?? "") as! String)
                scoreArrary.append((snapshot.data()["product_score"] ?? "") as! String)
                capacityArrary.append((snapshot.data()["capacity"] ?? "") as! String)
                uploadArrary.append((snapshot.data()["uploadby"] ?? "") as! String)
                UscoreArrary.append((snapshot.data()["UpScore"] ?? "") as! String)
            }
        }
        if(dataArrary.isEmpty == false){
            for i in 0...dataArrary.count-1{
                let spro = Product(PName: dataArrary[i], PImgName: dataArrary[i], PPrice: priceArrary[i], PCapacity: capacityArrary[i], PScore: scoreArrary[i], Pupload: uploadArrary[i], Puploadscore: UscoreArrary[i])
                    products.append(spro)
            }
        }
        dataArrary.removeAll()
        priceArrary.removeAll()
        scoreArrary.removeAll()
        capacityArrary.removeAll()
        uploadArrary.removeAll()
        UscoreArrary.removeAll()
    }
    
    func loadAllData(){
        db.collection("AllProducts").order(by: "time", descending: false).getDocuments { snapshot, error in
            guard let snapshot else { return }
            snapshot.documents.forEach { snapshot in
                allArrary.append((snapshot.data()["name"] ?? "") as! String)
            }
        }
        allArrary.removeAll()
    }
}
