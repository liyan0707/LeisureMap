//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpsw: UITextField!
    
    @IBOutlet var userbutton: [UIButton]!
    
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
    
}
