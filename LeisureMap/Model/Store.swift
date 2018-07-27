//
//  Store.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 tripim. All rights reserved.
//

import Foundation

class Store {
    var serviceIndex : Int = 0
    var Name : String?
    var StoreLocation:LocationDesc?
    var Index : Int = 0
    var Imagepath : String?

}

class LocationDesc {
    //地址
    var Address : String?
    //维度
    var Latitude :Double?
    //经度
    var Longitude:Double?
}
