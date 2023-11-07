//
//  Star.swift
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

var sn = String()

class Star: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var StarTableView: UITableView!
    
    var starDataProvider = StarDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StarTableView.delegate = self
        StarTableView.dataSource = self
        starDataProvider.loadStarData()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starDataProvider.starproducts.count
    }
    //每個cell的內容設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Starcell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath) as! StarTableViewCell
        // 顯示內容
        let starproduct = starDataProvider.starproducts[indexPath.row]
        let file = Storage.storage().reference().child("AllData/\(starproduct.StarName).jpg")
        file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
            Starcell.StarProductImg.image = UIImage(data: datas!)
        }
        Starcell.StarProductName.text = starproduct.StarName
        Starcell.StarProductRank.image = UIImage(named: starproduct.StarRank)
        let S = Float(starproduct.StarScore) ?? 0
        if S - Float(Int(S)) > 0.0 {
            sn = String(Float(Int(S))+0.5)
        } else {
            sn = String(Int(S))
        }
        Starcell.StarProductScore.image = UIImage(named: sn)
        return Starcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
