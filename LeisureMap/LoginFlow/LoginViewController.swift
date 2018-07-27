//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate, AsyncResponseDelegate ,FileWorkerDelegate{
    
  
     let stroreFileName : String  = "store.json"
     var requestWorker:AsyncRequestWorker?
     var fileWorker :FileWork?

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpsw: UITextField!
    @IBOutlet var userbutton: [UIButton]!
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        let account = username.text!
        let password  = userpsw.text!
        let from =  "https://score.azurewebsites.net/api/login/\(account)/\(password)"
        self.requestWorker?.getResponse(from:from, tag: 1)
        
    }
    
    func readServiceCategory(){
        
        let from = "https://score.azurewebsites.net/api/ServiceCategory"
        self.requestWorker?.getResponse(from: from, tag: 2)
        
    }
    
    func readStore(){
        
        let from = "https://score.azurewebsites.net/api/store"
        self.requestWorker?.getResponse(from: from, tag: 3)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        requestWorker = AsyncRequestWorker()
        requestWorker?.responseDelegate = self
        
        fileWorker = FileWork()
        fileWorker?.FileWorkerDelegate = self
        print("viewDidLoad")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewwillAppear")
    }
    

    
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         print("viewWilldisAppear")
    }
    
    
    override  func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDiddisAppear")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    //usenameset
    
      let accept = "abcdeABCDE"
      let cs = NSCharacterSet(charactersIn: accept).inverted
    //['a','b','c']
      let  filterd = string.components(separatedBy: cs).joined(separator: "")
    //["a","b","c"]
    
    
      if(string != filterd){
        
        return false
     }
    
    //maxlength
      var maxlength : Int = 0
    
      if textField.tag == 1 {
        
         maxlength = 5
        
      }
    
      if textField.tag == 2 {
        
         maxlength = 6
      }
    
      let   currentString :NSString = textField.text! as NSString
    
      let newString = currentString.replacingCharacters(in: range, with: string) as  NSString
  
       return  newString.length <= maxlength
    
    }
    //shouldin
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField.tag == 1 {
            
            textField.resignFirstResponder()
            
            userpsw.becomeFirstResponder()
            
            
        }
        if textField.tag == 2 {
            
            textField.resignFirstResponder()
        }
        return true
    }
    
    //shouldre
    func receviedReponse(_ sender: AsyncRequestWorker, responseString: String, tag: Int) {
        print("\(tag):\(responseString)")
        
        switch tag{
            
        case 1:
            self.readServiceCategory()
            break
            
        case 2:
            
            do{
                
                if let dataFromString = responseString.data(using: .utf8, allowLossyConversion: false) {
                    let json =  try JSON(data: dataFromString)
                    
                    let sqliteContext = SQLiteWorker()
                    sqliteContext.createDatabase()
                    
                    sqliteContext.clearAll()
                    
                    for (_ ,subJson):(String, JSON) in json {
                        // Do something you want
                        
                        let index :Int  = subJson["index"].intValue
                        let name : String = subJson["name"].stringValue
                        let iamgePath :String = subJson["iamgepath"].stringValue
                       // print("\(index):\(name)")
                        sqliteContext.insertData(_name: name, _imagepath: iamgePath)
                    }
                    
                    
//                    let categories = sqliteContext.readData()
//                    print(categories)
                
                }
            
                
                
            }
            catch{
                print(error)
                
            }
            
            self.readStore()
            break
                
        case 3:
            
            self.fileWorker?.writeToFile(content: responseString, fileName: "store.json", tag: 1)
            
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "MoveTouiview", sender: self)
            }
            break
            
        default:
            break
            
        }
    }
    //MARK: - UIIT
    
    func fileWorkWriteCompleted(_ sender: FileWork, filename: String, tag: Int) {
        
        print(filename)
    }
    
    func fileWorkReadCompleted(_ sender: FileWork, content: String, tag: Int) {
        
    }
    
    
}
