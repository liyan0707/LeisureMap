//
//  ServiceCellView.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class ServiceCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var bgimageview: UIImageView!
    
    
    @IBOutlet weak var lablename: UILabel!
    
    func updateContent(service:ServiceCategory)-> Void {
        lablename.text = service.Name 
    }
    
}
