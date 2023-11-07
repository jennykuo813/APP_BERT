//
//  NewStatus.swift
//  story
//
//  Created by 郭芳廷 on 2023/8/1.
//

import Foundation
import Foundation
import UIKit
import FirebaseStorage
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class NewStatus: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    
    
    
    
    
    
    var dataProvider = DataProvider()
    //宣告selectedProduct用來被存取的Product物件
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        dataProvider.loadData()
    }
    
    //每個session有幾筆資料
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.products.count
    }
    //每個cell的內容設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        // 顯示內容
        let product = dataProvider.products[indexPath.row]
        cell.productImg.image = UIImage(named: product.PImgName)
        cell.productLabel.text = product.PName
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = dataProvider.products[indexPath.row]
        performSegue(withIdentifier: "GoToDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? Goods{
            detailVC.Aproducts = selectedProduct
        }
    }
}
