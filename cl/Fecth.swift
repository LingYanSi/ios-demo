//
//  Ajax.swift
//  cl
//
//  Created by wujiadong on 16/9/24.
//  Copyright © 2016年 wujiadong. All rights reserved.
//

import UIKit

// http网络请求

class Fetch {
    // 请求成功
    var resolve: (String) -> Void
    // 请求失败
//    var reject: (String) -> Void = sth
    
    
    var url:String = ""
    
    init(url fetchUrl: String, option: Any = "") {
        // Dictionary<String, String>}
        /*
         option = {
            method: "post",
            body: "", // body可以传递String/json/file等
            cookie: "",// 是否带cookie
            dataType: "json/text/bolb"等，默认是json
         }
        */
        url = fetchUrl
        
        func a(ss: String){ }
        resolve = a
        
        ajax(url: url)
    }
    
    func sth(result: String){
        
    }
    
    private func ajax(url: String){
        // 这里会有一个then方法
        let requestUrl : URL = URL(string: url)!
        let requests : NSURLRequest = NSURLRequest(url: requestUrl)
        
        // 设置请求配置
        let configuration = URLSessionConfiguration.default
        // 实例化一个请求
        let session:URLSession = URLSession(configuration: configuration)
        
        // 异步任务内不能使用self来调用当前self
        let that = self
        // 配置请求任务
        let task:URLSessionDataTask = session.dataTask(with: requests as URLRequest, completionHandler: {
            (data:Data?, response:URLResponse?, error:Error?)->Void in
            // 处理请求结果
            if error == nil{
                do{
                    // json 转 Dictionary
                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    /*
                     error_code = 0
                     reason = ""
                     result = 数组套字典的城市列表
                     
                     */
                    
                    print("request结果:\(responseData)")
                }catch{
                    // data 转 字符串
                    let str: String = String(data: data!, encoding: String.Encoding.utf8)!
                    //                    print("请求字符串", str)
//                    that.resolve(str)
                    that.resolve("操你大爷 \(str)")
                }
            }
        })
        
        // 启动请求
        task.resume()
    }
    
    func then(fuck:  @escaping (String) -> Void) {
        
        resolve = fuck
        fuck("你好吗")
        
    }
}
