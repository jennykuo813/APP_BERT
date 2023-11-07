//
//  Home.swift
//  story
//
//  Created by 沈重光 on 2023/7/3.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

var MySearch = String()
var num = 0
var t = 0

class Home: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var tableview: UITableView!
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var more: UIBarButtonItem!

    var dataProvider = DataProvider()
    //宣告selectedProduct用來被存取的Product物件
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        dataProvider.loadData()
        CommentDataProvider().loadCommentData()
        NewDataProvider().loadNewData()
        self.imagePicker.delegate = self
        navigationItem.setHidesBackButton(true, animated: false)
        type()
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
        cell.productLabel.text = product.PName
        cell.productupload.text = product.Pupload
        cell.uploadscore.text = product.Puploadscore
        let file = Storage.storage().reference().child("AllData/\(product.PName).jpg")
        file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
                cell.productImg.image = UIImage(data: datas!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = dataProvider.products[indexPath.row]
        performSegue(withIdentifier: "gotoMid", sender: self)
        t = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? Mid {
            detailVC.Aproduct = selectedProduct
        }
    }
    
    @IBAction func SearchProduct(_ sender: Any) {
        self.performSegue (withIdentifier: "Into", sender: sender)
    }
    
    func type(){
        print(num)
        more.menu = UIMenu(children: [
            UIAction(title: "All", handler: { action in
                num = 1;
                self.dataProvider.loadData()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                    self.performSegue (withIdentifier: "wait", sender: self)
                }
            }),
            UIAction(title: "Drinks", handler: { action in
                num = 2;
                self.dataProvider.loadData()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                    self.performSegue (withIdentifier: "wait", sender: self)
                }
            }),
            UIAction(title: "Noodles", handler: { action in
                num = 3;
                self.dataProvider.loadData()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                    self.performSegue (withIdentifier: "wait", sender: self)
                }
            }),
            UIAction(title: "Rice", handler: { action in
                num = 4;
                self.dataProvider.loadData()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                    self.performSegue (withIdentifier: "wait", sender: self)
                }
            }),
            UIAction(title: "Cookies", handler: { action in
                num = 5;
                self.dataProvider.loadData()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                    self.performSegue (withIdentifier: "wait", sender: self)
                }
            }),
            UIAction(title: "Else", handler: { action in
                num = 6;
                self.dataProvider.loadData()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                    self.performSegue (withIdentifier: "wait", sender: self)
                }
            })
        ])
    }
}
