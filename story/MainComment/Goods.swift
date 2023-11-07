//
//  Goods.swift
//  story
//
//  Created by 李彤 on 2023/8/29.
//
import Network
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

var Asets = String()
var tt = 0

class Goods: UIViewController, UITableViewDataSource, UITableViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    private var connection: NWConnection?
    private var receiveData: Data = Data()
    
    var Aaproduct: Product?
    var db: Firestore!
    let imagePicker = UIImagePickerController()
    var comments: UserProduct?
    var goodsDataProvider = GoodsDataProvider()

    @IBOutlet weak var ProductUploadScore: UILabel!
    @IBOutlet weak var ProductUploadName: UILabel!
    @IBOutlet weak var backToHome: UIButton!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductImg: UIImageView!
    @IBOutlet weak var ProductScore: UIImageView!
    @IBOutlet weak var ProductCapacity: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var goodstableview: UITableView!
    @IBOutlet weak var MyComment: UITextField!
    @IBAction func popToOne(_ sender: Any) {
        if(t==0){
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.imagePicker.delegate = self
        set_goods()
        
        let file = Storage.storage().reference().child("AllData/\(n).jpg")
        file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
            self.ProductImg.image = UIImage(data: datas!)
        }
        ProductUploadScore.text = uss
        ProductUploadName.text = unn
        ProductCapacity.text = uc
        ProductPrice.text = um
        ProductName.text = n
        ProductScore.image = UIImage(named: s)
        goodstableview.delegate = self
        goodstableview.dataSource = self
        goodsDataProvider.loadgoodsData()
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func set_goods(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        MyComment.delegate = self
        MyComment.returnKeyType = .done //此處為設置按鍵類型
        MyComment.tag = 0 //設置編號
    }
    
    // 點畫面任意位置，收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 設置returnkey的功能
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            MyComment.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        if MyComment.isFirstResponder {
            backToHome.isHidden = true
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
        backToHome.isHidden = false
    }
       

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsDataProvider.userproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comcell = goodstableview.dequeueReusableCell(withIdentifier: "GoodsCell", for: indexPath) as! GoodsTableViewCell
        
        let allcomproduct = goodsDataProvider.userproducts[indexPath.row]
        comcell.UserScore.text = allcomproduct.Uscore
        if Auth.auth().currentUser != nil {
            self.db.collection("UserData").document(allcomproduct.UimgName).addSnapshotListener { snapshot, error in
                guard let snapshot else { return }
                guard let USER = try? snapshot.data(as: UserData.self) else { return }
                let file = Storage.storage().reference().child("users/\(USER.MAIL).jpg")
                file.getData(maxSize: 10 * 1024 * 1024) {  datas, error in
                    if error != nil {
                        comcell.UserImg.image = UIImage(named: "\(USER.GENDER)")
                    } else {
                        comcell.UserImg.image = UIImage(data: datas!)
                    }
                }
            }
        }
        
        comcell.UserName.text = allcomproduct.Uname
        comcell.UserComment.text = allcomproduct.Ucomment
        comcell.CommentDate.text = allcomproduct.Udate

        return comcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        comments = goodsDataProvider.userproducts[indexPath.row]
        performSegue(withIdentifier: "gotoMid2", sender: self)
        tt = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC2 = segue.destination as? Mid2 {
            detailVC2.Acomments = comments
        }
    }
    
    // 限制字數為50
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = MyComment.text!.count - range.length + string.count
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
    
    @IBAction func send_main(_ sender: Any) {
        if(self.MyComment.text != ""){
            if let user = Auth.auth().currentUser {
                self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                    guard let snapshot else { return }
                    guard let USER = try? snapshot.data(as: UserData.self) else { return }
                    Asets = "\(USER.TRUST_SCORE)"
                }
                self.db.collection("UserData").document(user.email!).addSnapshotListener { snapshot, error in
                    guard let snapshot else { return }
                    guard let USER = try? snapshot.data(as: UserData.self) else { return }
                    self.db.collection("AllProducts").document(self.ProductName.text!).collection("main").document(USER.MAIL).setData([
                        "main_comment": self.MyComment.text!,
                        "USER": Auth.auth().currentUser?.email! as Any,
                        "UserName": USER.NAME,
                        "aux_total": "0",
                        "DATE": Date().toString(dateFormat: "yyyy/MM/dd HH:mm:ss"),
                        "TIMER": Date(),
                        "P": "0",           
                        "S": "0",
                        "total_Z": "0",
                        "userscore": Asets
                    ])
                    self.db.collection("main_comment").document(self.ProductName.text!+USER.MAIL).setData([
                        "GoodsName": self.ProductName.text!,
                        "main_comment": self.MyComment.text!,
                        "USER": Auth.auth().currentUser?.email! as Any,
                        "UserName": USER.NAME,
                        "aux_total": "0",
                        "DATE": Date().toString(dateFormat: "yyyy/MM/dd HH:mm:ss"),
                        "TIMER": Date(),
                        "P": "0",
                        "S": "0",
                        "total_Z": "0",
                        "userscore": Asets
                    ])
                    { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            self.connectToServer()
                            let text = "AllProducts/\(self.ProductName.text!)/main/\(USER.MAIL)*\(self.MyComment.text!)"
                            if let data = text.data(using: .utf8) {
                                self.sendData(data: data)
                            } else {
                                print("Error: Unable to convert text to data")
                            }
                            self.view.endEditing(true)
                            self.MyComment.text = ""
                            let alert = UIAlertController(title: "Success!",
                                                          message: "You have successfully submitted the information.",
                                                          preferredStyle: .alert)
                            let backAction = UIAlertAction(title: "Back",
                                                           style: .cancel,
                                                           handler: {_ in Acomment().loadAcomment()
                                self.performSegue (withIdentifier: "load4", sender: self)
                                t = 1
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
                    print("連接失敗: \(error)")
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
