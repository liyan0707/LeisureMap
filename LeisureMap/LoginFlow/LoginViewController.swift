//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, AsyncResponseDelegate {
    
    var requestWorker:AsyncRequestWorker?

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpsw: UITextField!
    @IBOutlet var userbutton: [UIButton]!
    
    
    @IBAction func login(_ sender: Any) {
        
        let account = username.text!
        let password  = userpsw.text!
        let from =  "https://score.azurewebsites.net/api/login/\(account)/\(password)"
        self.requestWorker?.getResponse(from:from, tag: 1)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        requestWorker = AsyncRequestWorker()
        requestWorker?.responseDelegate = self
        print("123")
        
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
        print(responseString)
    }
    
}
