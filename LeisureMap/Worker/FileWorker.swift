//
//  FileWorker.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 tripim. All rights reserved.
//

import Foundation

protocol FileWorkerDelegate {
    func  fileWorkWriteCompleted(_ sender:FileWork,filename:String ,tag:Int)
    func  fileWorkReadCompleted(_ sender:FileWork,content:String ,tag:Int)
    
}
class FileWork{
    var FileWorkerDelegate :FileWorkerDelegate?
    
    func writeToFile(content:String, fileName:String,tag:Int ){
        if let dir = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first{
            
         let fileURL = dir .appendingPathComponent(fileName)
            do {
                
                try  content.write(to: fileURL, atomically: false, encoding: .utf8)
                self.FileWorkerDelegate?.fileWorkWriteCompleted( self, filename: fileURL.absoluteString, tag: tag)
                
            }
            catch{ print(error) }
            
            
            
        }
        
    
    }
    
    func  readFromFile(fileName:String , tag:Int) ->String{
        
        var result : String = ""
        if let dir = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first{
            
            let fileURL = dir .appendingPathComponent(fileName)
            do {
                
                let  content = try String( contentsOf: fileURL, encoding: .utf8 )
                self.FileWorkerDelegate?.fileWorkReadCompleted( self,content:content, tag: tag)
                
                result = content
                
            }
            catch{ print(error) }
            
            
            
        }
        return result
    }
    
    
    
}
