//
//  MasterViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterViewController: UIViewController, FileWorkerDelegate ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCellView", for: indexPath) as! ServiceCellView
        cell.updateContent(service:category)
        return  cell
   
    }
    
    var  categories :[ServiceCategory] = []
    var  stores: [Store] = []
    var  displayStore : [Store] = []
    var  selectedStore : Store?
   
    
    let stroreFileName : String  = "store.json"
    var fileWorker :FileWork?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
            let sqliteContext = SQLiteWorker()
          let categoriesindexsql = sqliteContext.readData()

          categories = categories + categoriesindexsql
        
        
        //
        fileWorker = FileWork()
        fileWorker?.FileWorkerDelegate = self
        let content = self.fileWorker?.readFromFile(fileName: stroreFileName, tag: 1)
        
        do{
            
            if let dataFromString = content?.data(using: .utf8, allowLossyConversion: false) {
                
                let json =  try JSON(data: dataFromString)
                for ( _ ,subJson):(String, JSON) in json {
                    // Do something you want
                    
                    let store : Store = Store()
                    let serviceIndex : Int = subJson["serviceIndex"].intValue
                    let index :Int  = subJson["index"].intValue
                    let name : String = subJson["name"].stringValue
                    let iamgePath :String = subJson["iamgepath"].stringValue
                    
                    let location : JSON = subJson["location"]
                    let  address : String = location["name"].stringValue
                    let latitude :Double = location["latitude"].doubleValue
                    let longitude : Double = location["longitude"].doubleValue
                    
                    store.serviceIndex = serviceIndex
                    store.Name = name
                    store.Index = index
                    store.Imagepath = iamgePath
                    store.StoreLocation = LocationDesc()
                    store.StoreLocation?.Address = address
                    store.StoreLocation?.Latitude = latitude
                    store.StoreLocation?.Longitude = longitude
                   // print("\(index):\(name):latitude:\(latitude)")
                   
                    stores.append(store)
                
                }
                
            }
            
            
        }
        catch{
            print(error)
            
        }
        displayStore = displayStore + stores

        // Do any additional setup after loading the view.
    }
    
    //MARK
    func fileWorkWriteCompleted(_ sender: FileWork, filename: String, tag: Int) {
        print("123")
    }
    
    func fileWorkReadCompleted(_ sender: FileWork, content: String, tag: Int) {
       print("123")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
