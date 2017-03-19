//
//  ViewController.swift
//  cl
//
//  Created by wujiadong on 16/9/11.
//  Copyright © 2016年 wujiadong. All rights reserved.
//


import UIKit

/**
 * 继承UIViewController用于UI显示
 * 继承UIImagePickerControllerDelegate协议
 * 继承UINavigationControllerDelegate协议
 */
class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var webView: WebView
    
    @IBOutlet weak var urlText: UITextField!
    
    @IBOutlet weak var urlBtn: UIButton!
    
    @IBAction func urlBtnCick(_ sender: AnyObject) {
        // 响应点击事件，并获取urlText内的值
        if let url = urlText.text {
            print(url)
            request(url: url)
        }
        
//        urlText.endEditing(true)
//        self.webView.setUrl(url)
    }
    
    @IBAction func cameraTap(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //创建图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //设置来源
            picker.sourceType = UIImagePickerControllerSourceType.camera
            //允许编辑
            picker.allowsEditing = false
            //打开相机
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
        }else{
            print("找不到相机")
        }
    }
    required init(coder aDecoder: NSCoder) {
        self.webView = WebView()
        super.init(coder: aDecoder)!
    }
    var ni = "哈哈哈"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        self.webView.setPosition(view)
        self.webView.setUrl("https://lingyansi.space")
        print(self.webView.url ?? "默认url")
        
        print(self.webView.backForwardList.item(at: 1) ?? "default value")
        
        // 关闭自动校正
        urlText.autocorrectionType = UITextAutocorrectionType.no 
        
        Fetch(url:"https://www.zhihu.com").then(fuck: {(result: String) -> Void in
            print(self.ni, result)
        })
        
        _ = Modal.tip(view: self.view!)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 页面跳转
    func jump(_ id: String) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        
        let vc = sb.instantiateViewController(withIdentifier: id) 
        
        //VC为该界面storyboardID，Main.storyboard中选中该界面View，Identifier inspector中修改
        
        self.present(vc, animated: true, completion: nil)
//        self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    // 网络请求
    func request(url: String){
        let requestUrl : URL = URL(string: url)!
        let requests : NSURLRequest = NSURLRequest(url: requestUrl)
        
        // 设置请求配置
        let configuration = URLSessionConfiguration.default
        // 实例化一个请求
        let session:URLSession = URLSession(configuration: configuration)
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
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    print("请求字符串", str)
                }
            }
        })
        
        // 启动请求
        task.resume()
    }
}
