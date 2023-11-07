//
//  User.swift
//  story
//
//  Created by 沈重光 on 2023/7/3.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class User: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var db: Firestore!

    @IBOutlet weak var MyPhoto: UIImageView!
    @IBOutlet weak var MyGender: UILabel!
    @IBOutlet weak var MyName: UILabel!
    @IBOutlet weak var MyMail: UILabel!
    @IBOutlet weak var MyPhone: UILabel!
    @IBOutlet weak var MyScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.imagePicker.delegate = self
        
        if let user = Auth.auth().currentUser {
            self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                guard let snapshot else { return }
                guard let USER = try? snapshot.data(as: UserData.self) else { return }
                self.MyName.text = USER.NAME
                self.MyMail.text = USER.MAIL
                self.MyGender.text = USER.GENDER
                self.MyPhone.text = USER.PHONE
                self.MyScore.text = "\(USER.TRUST_SCORE)"
                let fileReference = Storage.storage().reference().child("users/\(USER.MAIL).jpg")
                fileReference.getData(maxSize: 10 * 1024 * 1024) {  data, error in
                    if let error = error {
                        self.MyPhoto.image = UIImage(named: "\(USER.GENDER)")
                    } else {
                        self.MyPhoto.image = UIImage(data: data!)
                    }
                }
            }
        }
        navigationItem.setHidesBackButton(true, animated: false)
    }
  
    @IBAction func changeName(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            let changeAlert = UIAlertController(title: "修改名稱", message: "", preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "儲存", style: .default) { [self] (action) in
                let NameTextField = changeAlert.textFields![0]
                self.db.collection("UserData").document(user.email!).updateData([
                    "NAME": NameTextField.text!
                ])
                { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            changeAlert.addTextField {(NameTextField) in}
            changeAlert.addAction(saveAction)
            changeAlert.addAction(cancelAction)
            present(changeAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func changePhone(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            let changeAlert = UIAlertController(title: "修改電話號碼", message: "", preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "儲存", style: .default) { [self] (action) in
                let PhoneTextField = changeAlert.textFields![0]
                self.db.collection("UserData").document(user.email!).updateData([
                    "PHONE": PhoneTextField.text!
                ])
                { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            changeAlert.addTextField {(PhoneTextField) in}
            changeAlert.addAction(saveAction)
            changeAlert.addAction(cancelAction)
            present(changeAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func Logout(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: false)
                print("success logout")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func DeletePhoto(_ sender: Any) {
        let changeAlert = UIAlertController(title: "確定刪除頭像？", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "是的", style: .default) { [self] (action) in
            let desertRef = Storage.storage().reference().child("users/\(self.MyMail.text!).jpg")

            desertRef.delete { error in
              if let error = error {
              } else {
                  self.MyPhoto.image = UIImage(named: "\(self.MyGender.text!)")
              }
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        changeAlert.addAction(saveAction)
        changeAlert.addAction(cancelAction)
        present(changeAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func clicklibrarybutton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    
    @IBAction func clickuploadbutton(_ sender: Any) {
        if (MyPhoto.image == UIImage(named: "Female"))  {
            let alertController = UIAlertController(title: "圖片訊息", message: "請放入圖片", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if (MyPhoto.image == UIImage(named: "Male")){
            let alertController = UIAlertController(title: "圖片訊息", message: "請放入圖片", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else{
            uploadFile()
            let alert = UIAlertController(title: "Success!",
                                          message: "You have successfully submitted the information.",
                                          preferredStyle: .alert)
            let backAction = UIAlertAction(title: "Back",
                                           style: .cancel,
                                           handler: nil)
            alert.addAction(backAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ///關閉ImagePickerController
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ///取得使用者選擇的圖片
            self.MyPhoto.contentMode = .scaleAspectFill
            self.MyPhoto.image = pickedImage
            self.MyPhoto.layer.masksToBounds = true;
        }
     }

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       ///關閉ImagePickerController
       picker.dismiss(animated: true, completion: nil)
     }
    
    func uploadFile(){
        let url = URL(string: "https://XXXXXXXXXXXXXXXXXXXXXXXXXXX")
        let storageRef = Storage.storage().reference()
        let imageData: Data = MyPhoto.image!.jpegData(compressionQuality: 1.0)!

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("users/\(self.MyMail.text!).jpg")

        let uploadTask = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              return
            }
          }
        }
    }
}
