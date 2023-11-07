//
//  SignUp.swift
//  story
//
//  Created by 沈重光 on 2023/7/3.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


struct UserData: Codable, Identifiable {
    @DocumentID var id: String?
    let NAME: String
    let GENDER: String
    let MAIL: String
    let PASSWORD: String
    let PHONE: String
    let TRUST_SCORE: String
}

class SignUp: UIViewController , UIScrollViewDelegate, UITextFieldDelegate {


    @IBOutlet weak var Signup: UIButton!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var email_Signup: UITextField!
    @IBOutlet weak var password_Signup: UITextField!
    @IBOutlet weak var Confirm_password: UITextField!
    @IBOutlet weak var person: UIImageView!
    
    var db: Firestore!
    var myButtonIsSelect: Bool = false
    var gen : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        // Do any additional setup after loading the view.
        if (gender.selectedSegmentIndex == 0) {
            person.image = UIImage(named: "Male")
            self.gen = "Male"
        }
        else{
            person.image = UIImage(named: "Female")
            self.gen = "Female"
        }
        set_signup()
    }
    
    func set_signup(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        Name.delegate = self
        Name.returnKeyType = .next //此處為設置按鍵類型
        Name.tag = 0 //設置編號
        
        Phone.delegate = self
        Phone.returnKeyType = .next
        Phone.tag = 1
        
        email_Signup.delegate = self
        email_Signup.returnKeyType = .next
        email_Signup.tag = 2
        
        password_Signup.delegate = self
        password_Signup.returnKeyType = .next
        password_Signup.tag = 3
        
        Confirm_password.delegate = self
        Confirm_password.returnKeyType = .done
        Confirm_password.tag = 4
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
            Phone.becomeFirstResponder()
            break
        case 1:
            // 按returnkey，跳到 email_Signup
            email_Signup.becomeFirstResponder()
            break
        case 2:
            // 按returnkey，跳到 password_Signup
            password_Signup.becomeFirstResponder()
            break
        case 3:
            // 按returnkey，跳到 Confirm_password
            Confirm_password.becomeFirstResponder()
            break
        case 4:
            // 按done，收起鍵盤
            Confirm_password.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = Name.text!.count - range.length + string.count
        if countOfWords > 10 {
            
            let alert = UIAlertController(title: "很抱歉！",
                                          message: "您的名字需少於10個字",
                                          preferredStyle: .alert)
            let backAction = UIAlertAction(title: "Back",
                                           style: .cancel,
                                           handler: nil)
            alert.addAction(backAction)
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        if Phone.isFirstResponder {
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -160)
                self.view.transform = transform
            })
        }
        if email_Signup.isFirstResponder {
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -180)
                self.view.transform = transform
            })
        }
        if password_Signup.isFirstResponder {
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -200)
                self.view.transform = transform
            })
        }
        if Confirm_password.isFirstResponder {
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -200)
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
    
    @IBAction func gender(_ sender: Any) {
        if (gender.selectedSegmentIndex == 0) {
            person.image = UIImage(named: "Male")
            self.gen = "Male"
        }
        else{
            person.image = UIImage(named: "Female")
            self.gen = "Female"
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        if (self.email_Signup.text == "" || self.password_Signup.text == "" || self.Phone.text == "" || self.Name.text == "" || self.Confirm_password.text == "") {
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
            if (password_Signup.text! == Confirm_password.text!){
                Auth.auth().createUser(withEmail: email_Signup.text!, password: password_Signup.text!) { (result, error) in
                    if error == nil {
                        let alert = UIAlertController(title: "Caution",
                                                      message: "Successfully Sign up, now please Log in your account.",
                                                      preferredStyle: .alert)
                        let backAction = UIAlertAction(title: "Back",
                                                       style: .cancel,
                                                       handler: {_ in self.navigationController?.popToRootViewController(animated: true)})
                        
                        alert.addAction(backAction)
                        self.present(alert, animated: true)
                        let DATA = UserData(NAME: self.Name.text!, GENDER:self.gen, MAIL: self.email_Signup.text!, PASSWORD: self.password_Signup.text!, PHONE: self.Phone.text!, TRUST_SCORE: "60")
                        do {
                            try self.db.collection("UserData").document(self.email_Signup.text!).setData(from: DATA)
                            } catch {
                                print(error)
                            }
    
                    } else {
                        let alert = UIAlertController(title: "Caution",
                                                      message: error?.localizedDescription,
                                                      preferredStyle: .alert)
                        let backAction = UIAlertAction(title: "Back",
                                                       style: .cancel,
                                                       handler: nil)
                        alert.addAction(backAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "Caution",
                                              message: "Please confirm your password again!",
                                              preferredStyle: .alert)
                let backAction = UIAlertAction(title: "Back",
                                               style: .cancel,
                                               handler: nil)
                alert.addAction(backAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
