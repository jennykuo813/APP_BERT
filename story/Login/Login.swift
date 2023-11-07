//
//  Login.swift
//  story
//
//  Created by 沈重光 on 2023/7/3.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


class Login: UIViewController , UIScrollViewDelegate, UITextFieldDelegate {
    
  
    @IBOutlet weak var password_Login: UITextField!
    @IBOutlet weak var email_Login: UITextField!
    @IBOutlet weak var eye_button: UIButton!
    @IBOutlet weak var Login: UIButton!
    

    var mail: String = ""
    var db: Firestore!
    var myButtonIsSelect: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        DataProvider().loadData()
        NewDataProvider().loadNewData()
        CommentDataProvider().loadCommentData()
        StarDataProvider().loadStarData()
        DataProvider().loadAllData()
        set()
    }
    
    func set(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        email_Login.delegate = self
        email_Login.returnKeyType = .next //此處為設置按鍵類型
        email_Login.tag = 0 //設置編號
        
        password_Login.delegate = self
        password_Login.returnKeyType = .done
        password_Login.tag = 1
    }
    
    // 點畫面任意位置，收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 設置returnkey的功能
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            // 按returnkey，跳到 password_Login
            password_Login.becomeFirstResponder()
            break
        case 1:
            // 按done，收起鍵盤
            password_Login.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        if email_Login.isFirstResponder {
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -230)
                self.view.transform = transform
            })
        }
        if password_Login.isFirstResponder {
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -230)
                self.view.transform = transform
            })
        }
        
    }
 
    @objc private func keyboardWillHide(sender: NSNotification) {
        guard let userInfo = sender.userInfo else { return }
        let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
        UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
            self.view.transform = CGAffineTransform.identity
        })
    }
    
    
    
    @IBAction func eye_button(_ sender: UIButton) {
        if self.myButtonIsSelect {
            self.myButtonIsSelect = false
            self.eye_button.setImage(UIImage(systemName: "eye.slash"), for: UIControl.State.normal)
        } else {
            self.myButtonIsSelect = true
            self.eye_button.setImage(UIImage(systemName: "eye"), for: UIControl.State.normal)
        }
        sender.isSelected = !sender.isSelected
        self.password_Login.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func Login_button(_ sender: Any) {
        if self.email_Login.text == "" || self.password_Login.text == "" {
                let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: email_Login.text!, password: password_Login.text!) { (result, error) in
                if (error != nil) {
                     let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                     let defaultAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
                     alert.addAction(defaultAction)
                     self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.performSegue (withIdentifier: "IntoHome", sender: sender)
                    self.db.collection("UserData").document(self.email_Login.text!).updateData([
                        "PASSWORD": self.password_Login.text!,
                    ])
                    { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func ResetPassword(_ sender: AnyObject) {

        if self.email_Login.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().sendPasswordReset(withEmail: self.email_Login.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success!"
                    message = "Password reset email sent."
                    self.email_Login.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
}
