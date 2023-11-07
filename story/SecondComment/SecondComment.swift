//
//  SecondComment.swift
//  story
//
//  Created by 李彤 on 2023/9/4.
//
import Network
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

var Bsets = String()

class SecondComment: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var backToGoods: UIButton!
    @IBOutlet weak var MyComment2: UITextField!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var UserMainComment: UILabel!
    @IBOutlet weak var UserScore: UILabel!
    @IBOutlet weak var UserID: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    
    @IBAction func popToOne(_ sender: Any) {
        if(tt==0){
            guard let navController = navigationController else {return}
            let count = navController.viewControllers.count
            let pageOneController = navController.viewControllers[count - 3]
            navController.popToViewController(pageOneController, animated: false)
        }else{
            guard let navController = navigationController else {return}
            let count = navController.viewControllers.count
            let pageOneController = navController.viewControllers[count - 5]
            navController.popToViewController(pageOneController, animated: false)
        }
        
    }
    
    private var connection: NWConnection?
    private var receiveData: Data = Data()
    
    var seconddata = SecondDataProvider()
    var db: Firestore!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.imagePicker.delegate = self
        
        set_second()
        
        UserMainComment.text = cc
        UserScore.text = ss
        UserID.text = nn
        db.collection("UserData").document(mm).addSnapshotListener { snapshot, error in
            guard let snapshot else { return }
            guard let USER = try? snapshot.data(as: UserData.self) else { return }
            let file = Storage.storage().reference().child("users/\(mm).jpg")
            file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
                if error != nil {
                    self.UserImage.image = UIImage(named: "\(USER.GENDER)")
                } else {
                    self.UserImage.image = UIImage(data: datas!)
                }
            }
        }
        
        tableView2.delegate = self
        tableView2.dataSource = self
        seconddata.loadsecondData()
    }

    func set_second(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        MyComment2.delegate = self
        MyComment2.returnKeyType = .done
        MyComment2.tag = 0
    }
    
    // 點畫面任意位置，收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 設置returnkey的功能
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            MyComment2.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        if MyComment2.isFirstResponder {
            backToGoods.isHidden = true
            guard let userInfo = sender.userInfo else { return }
            let duration: Float = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue
            UIView.animate(withDuration: TimeInterval(duration), animations: { () -> Void in
                let transform = CGAffineTransform(translationX: 0, y: -310)
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
        backToGoods.isHidden = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seconddata.seconduserproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comcell2 = tableView2.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondTableViewCell
        let comproduct2 = seconddata.seconduserproducts[indexPath.row]
        comcell2.UserScore2.text = comproduct2.Usscore
        comcell2.UserName2.text = comproduct2.Usname
        comcell2.UserComment2.text = comproduct2.Uscomment
        comcell2.CommentDate2.text = comproduct2.Usdate
        
        if let user = Auth.auth().currentUser {
            self.db.collection("UserData").document(comproduct2.UsimgName).addSnapshotListener { snapshot, error in
                guard let snapshot else { return }
                guard let USER = try? snapshot.data(as: UserData.self) else { return }
                let file = Storage.storage().reference().child("users/\(comproduct2.UsimgName).jpg")
                file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
                    if error != nil {
                        comcell2.UserImg2.image = UIImage(named: "\(USER.GENDER)")
                    } else {
                        comcell2.UserImg2.image = UIImage(data: datas!)
                    }
                }
            }
        }
        return comcell2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    // 限制字數為20
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = MyComment2.text!.count - range.length + string.count
        if countOfWords > 50 {
            
            let alert = UIAlertController(title: "很抱歉！",
                                          message: "您的評論需少於50個字",
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
    
    @IBAction func send_second(_ sender: Any) {
        if(self.MyComment2.text != ""){
            if let user = Auth.auth().currentUser {
                self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                    guard let snapshot else { return }
                    guard let USER = try? snapshot.data(as: UserData.self) else { return }
                    Bsets = "\(USER.TRUST_SCORE)"
                }
                self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                    guard let snapshot else { return }
                    guard let USER = try? snapshot.data(as: UserData.self) else { return }
                    self.db.collection("AllProducts").document(n).collection("main").document(mm).collection("second").document(USER.MAIL).setData([
                        "aux_comment": self.MyComment2.text!,
                        "USER": Auth.auth().currentUser?.email! as Any,
                        "UserName": USER.NAME,
                        "DATE": Date().toString(dateFormat: "yyyy/MM/dd HH:mm:ss"),
                        "TIMER": Date(),
                        "P": "0",
                        "Z": "0",
                        "ReplyTo": nn,
                        "userscore": Bsets
                    ])
                    self.db.collection("second_comment").document(nn+n+USER.MAIL).setData([
                        "GoodsName": n,
                        "aux_comment": self.MyComment2.text!,
                        "USER": Auth.auth().currentUser?.email! as Any,
                        "UserName": USER.NAME,
                        "DATE": Date().toString(dateFormat: "yyyy/MM/dd HH:mm:ss"),
                        "TIMER": Date(),
                        "P": "0",
                        "Z": "0",
                        "ReplyTo": nn,
                        "userscore": Bsets
                    ])
                    { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            self.connectToServer()
                            let text = "AllProducts/\(n)/main/\(mm)/second/\(USER.MAIL)*\(self.MyComment2.text!)"
                            if let data = text.data(using: .utf8) {
                                self.sendData(data: data)
                            } else {
                                // Handle the case where the text cannot be converted to data (e.g., invalid encoding).
                                print("Error: Unable to convert text to data")
                                // You can choose to show an error message or take other appropriate action here.
                            }
                            self.view.endEditing(true)
                            self.MyComment2.text = ""
                            
                            let alert = UIAlertController(title: "Success!",
                                                          message: "You have successfully submitted the information.",
                                                          preferredStyle: .alert)
                            let backAction = UIAlertAction(title: "Back",
                                                           style: .cancel,
                                                           handler: {_ in  Bcomment().loadBcomment()
                                self.performSegue (withIdentifier: "load5", sender: self)
                                tt = 1
                            })
                            alert.addAction(backAction)
                            self.present(alert, animated: true, completion: nil)
                            print("Document successfully written!")
                        }
                    }
                }
            }
        }
    }
    
    func connectToServer() {
        let host = "127.0.0.1"
        let port = 6666
        
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(host), port: NWEndpoint.Port(rawValue: UInt16(port))!)
        connection = NWConnection(to: endpoint, using: .tcp)
        
        connection?.stateUpdateHandler = { [weak self] newState in
            guard let self = self else { return }
            
            switch newState {
            case .ready:
                DispatchQueue.main.async {
                    print("已連接")
                }
                self.startReceivingData()
                
            case .failed(let error):
                DispatchQueue.main.async {
                    print("連接失败: \(error)")
                }
                
            default:
                break
            }
        }
        
        connection?.start(queue: .global())
    }
    

    func startReceivingData() {
      connection?.receive(minimumIncompleteLength: 1, maximumLength: 65536) { [weak self] (data, context, isComplete, error) in
          guard let self = self else { return }
          
          if let data = data, !data.isEmpty {
              if let receivedString = String(data: data, encoding: .utf8) {
                  DispatchQueue.main.async {

                      //self.Text_label.text = receivedString
                      if receivedString == "1"{
                          print("好評")
                      }
                      else{
                          print("差評")
                      }
                  }
              }
          }
          
          if let error = error {
              DispatchQueue.main.async {
                  print("Failed to receive data: : \(error)")
              }
          } else {
              self.startReceivingData()
          }
      }
    }

    func sendData(data: Data) {
       // Send the data
       self.connection?.send(content: data, completion: .contentProcessed { [weak self] error in
           guard let self = self else { return }
           
           if let error = error {
               DispatchQueue.main.async {
                   print("Failed : \(error)")
               }
           } else {
               DispatchQueue.main.async {
                   print("Data sent successfully")
               }
           }
       })
    }
}
