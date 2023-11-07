//
//  image.swift
//  story
//
//  Created by 郭芳廷 on 2023/7/27.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

var bb = 0

class image: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var choosetype: UIButton!
    @IBOutlet weak var choosegml: UIButton!
    @IBOutlet weak var backToNew: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var GoodsNameTextField: UITextField!
    @IBOutlet weak var GoodsPriceTextField: UITextField!
    @IBOutlet weak var GoodsCapacityTextField: UITextField!
    @IBAction func popToOne(_ sender: Any) {
        if(bb == 0){
            guard let navController = navigationController else {return}
            let count = navController.viewControllers.count
            let pageOneController = navController.viewControllers[count - 2]
            navController.popToViewController(pageOneController, animated: false)
        }else{
            self.performSegue (withIdentifier: "bback", sender: self)
        }
    }
    let imagePicker = UIImagePickerController()
    var cap : String = ""
    var typ : String = ""
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.imagePicker.delegate = self
        
        set_new()
        
        choosegml.showsMenuAsPrimaryAction = true
        choosegml.changesSelectionAsPrimaryAction = true
        choosegml.menu = UIMenu(children: [
            UIAction(title: "請選擇單位", state: .on, handler: { action in
                self.cap = ""
            }),
            UIAction(title: "ml", handler: { action in
                self.cap = "ml"
            }),
            UIAction(title: "g", handler: { action in
                self.cap = "g"
            })
        ])
        choosetype.showsMenuAsPrimaryAction = true
        choosetype.changesSelectionAsPrimaryAction = true
        choosetype.menu = UIMenu(children: [
            UIAction(title: "請選擇類別", state: .on, handler: { action in
                self.typ = ""
            }),
            UIAction(title: "Drinks", handler: { action in
                self.typ = "Drinks"
            }),
            UIAction(title: "Noodles", handler: { action in
                self.typ = "Noodles"
            }),
            UIAction(title: "Rice", handler: { action in
                self.typ = "Rice"
            }),
            UIAction(title: "Cookies", handler: { action in
                self.typ = "Cookies"
            }),
            UIAction(title: "Else", handler: { action in
                self.typ = "Else"
            })
        ])
    }
    
    func set_new(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        GoodsNameTextField.delegate = self
        GoodsNameTextField.returnKeyType = .next
        GoodsNameTextField.tag = 0
        
        GoodsPriceTextField.delegate = self
        GoodsPriceTextField.returnKeyType = .next
        GoodsPriceTextField.tag = 1
        
        GoodsCapacityTextField.delegate = self
        GoodsCapacityTextField.returnKeyType = .next
        GoodsCapacityTextField.tag = 2
    }
    
    // 點畫面任意位置，收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 設置returnkey的功能
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            // 按returnkey，跳到 Phone
            GoodsPriceTextField.becomeFirstResponder()
            break
        case 1:
            // 按returnkey，跳到 email_Signup
            GoodsCapacityTextField.becomeFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        if GoodsPriceTextField.isFirstResponder {
            backToNew.isHidden = true
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -160)
                self.view.transform = transform
            })
        }
        if GoodsCapacityTextField.isFirstResponder {
            backToNew.isHidden = true
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -180)
                self.view.transform = transform
            })
        }
    }
 
    @objc private func keyboardWillHide(sender: NSNotification) {
        backToNew.isHidden = false
        guard let userInfo = sender.userInfo else { return }
        let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
        UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
            self.view.transform = CGAffineTransform.identity
        })
    }
    
    @IBAction func clickuploadbutton(_ sender: Any) {
        if imageview.image == UIImage(systemName: "photo"){
            let alertController = UIAlertController(title: "圖片訊息", message: "請放入圖片", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if(self.cap == ""){
            let alertController = UIAlertController(title: "Caution", message: "請選擇單位", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if(self.typ == ""){
            let alertController = UIAlertController(title: "Caution", message: "請選擇類別", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if(GoodsNameTextField.text == "" || GoodsPriceTextField.text == "" || GoodsCapacityTextField.text == ""){
            let alert = UIAlertController(title: "Caution",
                                          message: "Field can't be empty.",
                                          preferredStyle: .alert)
            let backAction = UIAlertAction(title: "Back",
                                           style: .cancel,
                                           handler: nil)
            alert.addAction(backAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            uploadFile()
            if let user = Auth.auth().currentUser {
                self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                    guard let snapshot else { return }
                    guard let USER = try? snapshot.data(as: UserData.self) else { return }
                    self.db.collection("GoodsData").document(self.GoodsNameTextField.text!+USER.MAIL).setData([
                        "GOODS_NAME": self.GoodsNameTextField.text!,
                        "PRICE": self.GoodsPriceTextField.text! + "元",
                        "Capacity": self.GoodsCapacityTextField.text! + " " + self.cap,
                        "TYPE": self.typ,
                        "USER": Auth.auth().currentUser?.email! as Any,
                        "DATE": Date().toString(dateFormat: "yyyy/MM/dd"),
                        "TIMER": Date(),
                        "StorageName":"\(self.GoodsNameTextField.text!+USER.MAIL).jpg"
                    ])
                    self.db.collection("AllProducts").document("\(self.GoodsNameTextField.text!)").setData([
                        "name": self.GoodsNameTextField.text!,
                        "price": self.GoodsPriceTextField.text! + "元",
                        "capacity": self.GoodsCapacityTextField.text! + " " + self.cap,
                        "time": Date(),
                        "uploadby":USER.NAME,
                        "UpScore": "\(USER.TRUST_SCORE)",
                        "type": "\(self.typ)"
                    ])
                    { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            let alert = UIAlertController(title: "Success!",
                                                          message: "You have successfully submitted the information.",
                                                          preferredStyle: .alert)
                            let backAction = UIAlertAction(title: "Back",
                                                           style: .cancel,
                                                           handler: nil)
                            alert.addAction(backAction)
                            self.present(alert, animated: true, completion: nil)
                            print("Document successfully written!")
                        }
                    }
                    bb = 1
                }
            }
        }
    }
    
    @IBAction func clicklibrarybutton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ///關閉ImagePickerController
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ///取得使用者選擇的圖片
            imageview.contentMode = .scaleAspectFill
            imageview.image = pickedImage
            imageview.layer.masksToBounds = true;
        }
     }

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       ///關閉ImagePickerController
       picker.dismiss(animated: true, completion: nil)
     }
    
    func uploadFile(){
        let url = URL(string: "https://XXXXXXXXXXXXXXXXXXXXXXXXXXX")
        // Create a root reference
        let storageRef = Storage.storage().reference()

        // Data in memory
        let imageData: Data = imageview.image!.jpegData(compressionQuality: 1.0)!

        if let user = Auth.auth().currentUser {
            self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                guard let snapshot else { return }
                guard let USER = try? snapshot.data(as: UserData.self) else { return }
                // Create a reference to the file you want to upload
                let riversRef = storageRef.child("NewData/\(self.GoodsNameTextField.text! + USER.MAIL).jpg")
                let riversRef2 = storageRef.child("AllData/\(self.GoodsNameTextField.text!).jpg")
                let uploadTask = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
                  guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                  }
                  // Metadata contains file metadata such as size, content-type.
                  let size = metadata.size
                  // You can also access to download URL after upload.
                  riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      // Uh-oh, an error occurred!
                      return
                    }
                  }
                }
                let uploadTask2 = riversRef2.putData(imageData, metadata: nil) { (metadata, error) in
                  guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                  }
                  // Metadata contains file metadata such as size, content-type.
                  let size = metadata.size
                  // You can also access to download URL after upload.
                  riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      // Uh-oh, an error occurred!
                      return
                    }
                  }
                }
            }
        }
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
