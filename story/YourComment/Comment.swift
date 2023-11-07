//
//  Comment.swift
//  story
//
//  Created by 沈重光 on 2023/7/3.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


class Comment: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var CommentTableView: UITableView!
    
    var commentDataProvider = CommentDataProvider()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        commentDataProvider.loadCommentData()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentDataProvider.commentproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comcell = CommentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        let allcomproduct = commentDataProvider.commentproducts[indexPath.row]
        comcell.commentDate.text = allcomproduct.Cdate
        let file = Storage.storage().reference().child("AllData/\(allcomproduct.CimgName).jpg")
        file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
            comcell.commentImg.image = UIImage(data: datas!)
        }
        comcell.commentName.text = allcomproduct.Cname
        comcell.comments.text = allcomproduct.Ccom
        if(allcomproduct.Cuser != ""){
            comcell.commentTo.text = "Replied to: " + allcomproduct.Cuser
        }

        return comcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
