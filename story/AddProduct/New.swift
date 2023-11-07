//
//  New.swift
//  story
//
//  Created by 李彤 on 2023/7/17.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class New: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    @IBOutlet weak var newTableView: UITableView!
    let imagePicker = UIImagePickerController()

    
    var newDataProvider = NewDataProvider()
    override func viewDidLoad() {
        bb = 0
        super.viewDidLoad()
        DataProvider().loadAllData()
        newTableView.delegate = self
        newTableView.dataSource = self
        newDataProvider.loadNewData()
        self.imagePicker.delegate = self
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newDataProvider.newproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newcell = newTableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! NewTableViewCell
        let allnewproduct = newDataProvider.newproducts[indexPath.row]
        newcell.newDate.text = allnewproduct.Ndate
        newcell.newName.text = allnewproduct.Nname
        newcell.newPrice.text = allnewproduct.Nprice
        
        print(allnewproduct.NimgName)
        let fileReference = Storage.storage().reference().child("NewData/\(allnewproduct.NimgName)")
        fileReference.getData(maxSize: 10 * 1024 * 1024) {  data, error in
            newcell.newImg.image = UIImage(data: data!)
        }
        return newcell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
