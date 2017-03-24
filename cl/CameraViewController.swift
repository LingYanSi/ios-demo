//
//  CameraViewController.swift
//  cl
//
//  Created by wujiadong on 16/9/18.
//  Copyright © 2016年 wujiadong. All rights reserved.
//

import UIKit
import Kingfisher
import URLNavigator

class CameraViewController: UIViewController, URLNavigable {
    
    var width : CGFloat = CGFloat(0)
    var height : CGFloat = CGFloat(0)
    // 创建一个异步线程
    let queue = DispatchQueue.init(label: "image")
    // 主线程
    let mainQueue = DispatchQueue.main
    
    var Table:UITableView = UITableView()
    
    init(userID: Int) {
        super.init(nibName: nil, bundle: nil)
        // Initialize here...
    }
    
    required init?(coder aDecoder: NSCoder) {
         
        super.init(coder: aDecoder)!
    }
    
    convenience required init?(url: URLConvertible, values: [String: Any], userInfo: [AnyHashable: Any]?) {
        // Let's assume that the user id is required
        guard let userID = values["id"] as? Int else { return nil }
        print(userID, "你好")
        self.init(userID: userID)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = view.bounds.width
        height = width / 10 * 6
        
        view.backgroundColor = UIColor.red
        
        let data = ImageCahe().download("http://o9fl7r0ix.bkt.clouddn.com/img/2016/file014726535260430.1080x1920.jpeg")
        let cacheImage = UIImage(data: data as Data)
        let Image = UIImageView()
        let moreHeight = height / 2
        Image.image = cacheImage
        Image.frame = CGRect(x: 0, y: 0 - moreHeight, width: width, height: height + moreHeight)
        
        addTable()
        Table.addSubview(Image)
        
        addBackButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 添加返回按钮
    func addBackButton() {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 15, width: 100, height: 50)
        btn.setTitle("back", for: UIControlState.normal)
        
        btn.addTarget(self, action: #selector(CameraViewController.back), for: UIControlEvents.touchDown)
        
        view.addSubview(btn)
    }
    
    func back() {
        print("返回")
        // 在swift3中，如果一个表达式返回一个结果，但你不用，需要明确的用 _ = expression 来告诉编译器，你不使用
        _ = self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    func addImage(_ url: String) -> UIImageView{
    
        let Image: UIImageView = UIImageView()

        //        Image = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width / 10 * 6))

        // set view position
        Image.frame = CGRect(x: 0, y: 0, width: width, height: self.view.bounds.height)
        
        // 不使用主线程去下载文件
        queue.async {
            let data = ImageCahe().download(url)
            let image = UIImage(data: data as Data)
            // 使用主线程更新UI
           self.mainQueue.async {
                Image.image = image
            }
            
        } 
        // 设置背景色 rgb为<=1的float类型
//        Image.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        
        Image.isOpaque = true

        // 类似于background-size
//        Image.contentMode = UIViewContentMode.scaleAspectFill

        // 设置圆角
//        Image.layer.cornerRadius = 8

        // overflow hidden，默认超出view还是会显示
//        Image.clipsToBounds = true

        // 把Image添加到View
//        view.addSubview(Image)
        
        return Image
    }
    
    let cellID = "fuck"
    var dataArr :[String] = []
    
    func addTable(){
        dataArr = [
            "http://ww3.sinaimg.cn/mw690/63918611gw1f81sss0qvqj208c06ogls.jpg",
            "https://odj7gwx6q.qnssl.com/img/2016/file014726538906750.2560x1920.jpeg",
            "http://ww1.sinaimg.cn/mw1024/006uFQHggw1f7wi8xvh42j30zk0qoti4.jpg",
            "http://ww1.sinaimg.cn/mw1024/006uFQHggw1f7uf47iplzj30zk0qowxj.jpg",
            "http://ww2.sinaimg.cn/mw1024/006uFQHggw1f7lswrfxotj30zk0qodqy.jpg",
            
            "http://ww2.sinaimg.cn/mw1024/621d03b7jw1f82dw5btj2j20zk0qogy0.jpg",
            "http://ww2.sinaimg.cn/mw1024/621d03b7jw1f82dw7bpopj20m80eth3j.jpg",
            "http://ww4.sinaimg.cn/mw1024/621d03b7jw1f82dw8ah39j20zk0lgtgj.jpg",
            
            "http://ww4.sinaimg.cn/mw1024/b2664ecdjw1f82c4x622tj21jk111k0w.jpg",
            "http://ww1.sinaimg.cn/mw1024/b2664ecdjw1f827tpej7aj21jk111ahr.jpg",
            "http://ww4.sinaimg.cn/mw1024/b2664ecdjw1f826lrpycej21jk10znef.jpg",
            "http://ww3.sinaimg.cn/mw1024/b2664ecdjw1f826lx2batj21jk15uax3.jpg",
        ]
        Table = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: view.bounds.height ), style: UITableViewStyle.plain  )
        
        
//        Table.backgroundColor = UIColor.blue
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        Table.delegate = self
        Table.dataSource = self
        
        // Register the table view cell class and its reuse id
        Table.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        view.addSubview(Table)
    }
    
    func setImage(url: String, Image: UIImageView){
        
        // 不使用主线程去下载文件
        // 需要把下载的图片剪切成小图
        queue.async {
            let data = ImageCahe().download(url)
            let image = UIImage(data: data as Data) 
            // 使用主线程更新UI
            self.mainQueue.async {
                Image.image = image
            }
            
        }
    }
    
    var fuckDictionary = [Int: Int]()
}

extension CameraViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK:- UITableViewDataSource数据源
    // 必须实现UITableViewDataSource的option修饰的必须实现的方法,否则会报错
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // create a new cell if needed or reuse an old one
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        
        
//        let borderColor = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 0.0/255.0, alpha: 0.6)
        // CGColor 可以通过UIColor的属性cgColor获取
//        cell.layer.borderColor = borderColor.cgColor
        
        
        // 为cell添加tag 并把cell内的Image的tag缓存起来
        let url = dataArr[indexPath.row]
        let imageTag = indexPath.row + 100
        var cellTag = 10 + indexPath.row
        
        print(cell.tag)
        if cell.tag == 0 {
            cell.tag = cellTag
        }
        
        cellTag = cell.tag
        
        let cellImageTag : Int = fuckDictionary[cellTag] ?? 0
        
        if cellImageTag > 0 {
           let Image: UIImageView = cell.contentView.viewWithTag(cellImageTag) as! UIImageView
//            setImage(url: url, Image: Image )
            
            let urlFuck = URL(string: url)
            Image.kf.setImage(with: urlFuck)
            
        } else {
            print("新建后渲染")
            
            cell.textLabel?.textColor = UIColor.red
            cell.layer.borderWidth = 4
            cell.textLabel?.text = "测试数据\(indexPath.row)"
            
            let Image : UIImageView = UIImageView()
            Image.frame = CGRect(x: 0, y: 0, width: width, height: height)
            Image.isOpaque = true
            Image.tag = imageTag
            Image.contentMode = UIViewContentMode.scaleAspectFill
            Image.clipsToBounds = true
            
            fuckDictionary[cell.tag] = imageTag
            
            let urlFuck = URL(string: url)
            Image.kf.setImage(with: urlFuck)
            
            cell.contentView.addSubview( Image )
//            setImage(url: url, Image: Image )
            
        }
        
//        print("数量", cell.contentView.subviews.count, cellTag, cellImageTag, fuckDictionary)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
    // MARK:- UITableViewDelegate代理
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击了\(indexPath.row)")
    }
    
    // 这两个方法用来实现在UITableView上添加一个一般View，以期望和UITableView一起滚动
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.isUserInteractionEnabled = true;
        
        view.isHidden = true;
        
        return view;
    }
    
}
