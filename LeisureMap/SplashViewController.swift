//
//  SplashViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController,AsyncResponseDelegate {
    
  
    var requestWorker:AsyncRequestWorker?
    
    var appVersion : String = ""

    @IBOutlet weak var Lableversion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults : UserDefaults = UserDefaults.standard
        defaults.synchronize()
        appVersion = "" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as?  String)!
        Lableversion.text =  appVersion
        
    //
        requestWorker = AsyncRequestWorker()
        requestWorker?.responseDelegate = self
      
        
        let from =  "https://score.azurewebsites.net/api/version/\( String( describing: appVersion))"
        
        self.requestWorker?.getResponse(from: from, tag: 1)
        
        
//        let url = URL(string : from)!
//        let request = URLRequest(url: url)
//
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        let task = session.dataTask(with: request, completionHandler:{ (data,response ,error ) in
//
//        let httpResponse = response  as! HTTPURLResponse
//
//        let statusCode = httpResponse.statusCode
//
//        if( 200 == statusCode){
//                let dataString = NSString(data:data! ,  encoding :String.Encoding.utf8.rawValue)
//                let responseString = String(dataString!)
//
//                print(responseString)
//
//            }
//           // print("HERE")
//
//        })
//
//         task.resume()
        
    }
//
    
    
        func receviedReponse(_ sender: AsyncRequestWorker, responseString: String, tag: Int) {
          print(responseString)
            
        let defaults : UserDefaults = UserDefaults.standard
        defaults.set(responseString, forKey: "serviceVersion")
        defaults.synchronize()
            
        DispatchQueue.main.async {
                
            self.performSegue(withIdentifier: "moveToLoginViewsure", sender: self)
            }
    
     }
        
    

        // Do any additional setup after loading the view.
    }

//    override func didReceiveMemoryWarning() {
//
//       // super.didReceiveMemoryWarning()
//
//
//        // Dispose of any resources that can be recreated.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


