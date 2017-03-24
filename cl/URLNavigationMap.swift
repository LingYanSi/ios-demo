//
//  URLNavigationMap.swift
//  cl
//
//  Created by wangyong on 2017/3/24.
//  Copyright © 2017年 wujiadong. All rights reserved.
//

import Foundation
import URLNavigator

struct URLNavigationMap {
    
    static func initialize() {
        Navigator.map("myapp://user/<int:id>", CameraViewController.self) 
        
//        Navigator.map("myapp://alert") { url, values in
//            print(url.queryParameters["title"])
//            print(url.queryParameters["message"])
//            self.someUtilityMethod()
//            return true
//        }
    }
    
    private static func someUtilityMethod() {
        print("This method is really useful")
    }
    
}
