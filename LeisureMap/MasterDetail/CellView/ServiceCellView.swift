//
//  ServiceCellView.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import SDWebImage

import Alamofire
import AlamofireImage

class ServiceCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var bgimageview: UIImageView!
    
    
    @IBOutlet weak var lablename: UILabel!
    

    
    func updateContent(service:ServiceCategory)-> Void {
        lablename.text = service.Name
       // bgimageview.sd_setImage(with: URL(string: service.ImagePath!), placeholderImage: UIImage(named: "placeholder"))
        bgimageview.sd_setImage(with: URL(string: service.ImagePath!), placeholderImage: UIImage(named: "placeholder"))
        
        
        Alamofire.request(service.ImagePath!).responseImage { response in
            if let image = response.result.value {
                
                self.bgimageview.image = image
                print("image downloaded: \(image)")
            }
        }
    }
    
}
