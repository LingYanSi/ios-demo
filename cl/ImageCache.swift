//
//  ImageCache.swift
//  cl
//  图片缓存，如果在主线程直接下载图片，会造成主线程卡顿，也就是说所有比较费时的任务，都应该放在其他线程中执行
//
//  Created by wujiadong on 16/9/20.
//  Copyright © 2016年 wujiadong. All rights reserved.
//

import UIKit

struct ImageCahe {
    let DIR = NSHomeDirectory()
    var ImgDir = ""
    
    init(){
        ImgDir = DIR + "/Library/Caches/img/"
    }
    
    func get(_ url: String) -> String {
        // 先去文件夹中查找，没有则去下载，下载成功后，再去查找一遍
        let manager = FileManager.default
        
//        var a = FileManager.SearchPathDirectory.documentDirectory
        
        // 获取document路径 itunes会同步
        var paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        var documentDirectory = paths[0]
        print("document 路径:", documentDirectory)
        
        print(NSHomeDirectory())
        
        // 获取library路径 除了Caches内文件，其他会同步
        paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        documentDirectory = paths[0]
        print("library 路径:", documentDirectory)
        
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: documentDirectory)
        print("文件结构:", contentsOfPath)
        
        // 获取tmp路径 临时文件，会在app关闭后被清空
        documentDirectory = NSTemporaryDirectory()
        print("tmp 路径:", documentDirectory)
        
        let ImageName = "http://www.baidu.com/aa.jpg?ddd=111&222/format/"
        print("md5:", ImageName.md5())
        
        // 下载文件
        // let fileName = writeString(url)
//        let fileContent = getTxtFile(fileName)
//        print(fileName, ":", fileContent)
        
//        let img = download("http://o9fl7r0ix.bkt.clouddn.com/img/2016/file014726535260430.1080x1920.jpeg?imageView2/2/q/75")
//        print("图片地址:", imgUrl)
        
        return ""
    }
    
    func mkdir(_ path: String) {
        // 如果路径已存在，就不要再创建
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func getTxtFile(_ path: String) -> String {
        if !fileExists(path) {
            return ""
        }
        
        let fileManager = FileManager.default
        let data = fileManager.contents(atPath: path)

        
        // 存在就返回文件内容
        let readingStr = String(data: data!, encoding: String.Encoding.utf8)
        return readingStr!
    }
    
    func writeString(_ content: String = "", FILENAME: String = "") -> String{
        // 文件名称
        let fileName = ImgDir + FILENAME
        
        // 字符串写入到文件
        try! content.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
        
        return fileName
    }
    
    func fileExists(_ path: String) -> Bool {
        let fileManager = FileManager.default
        // 如果不存在就返回一个空字符串
        return fileManager.fileExists(atPath: path)
    }
    
    
    func download(_ url: String) -> NSData {
        
        // 新建图片路径
        mkdir(ImgDir)
        
        var fileName = url.md5()
        fileName = ImgDir + fileName
        
        if fileExists(fileName) {
            print("文件已存在")
            let data = NSData(contentsOfFile: fileName)
            return data!
        }
        
        print("从网络获取")
        
        let imageUrl = NSURL(string: url)
        
        let data: NSData = try! NSData(contentsOf: imageUrl as! URL)
        
        let minData: Data = scaleImage(data: data, size: CGSize(width: 320, height: 200) )
        
        let file = NSData(data: minData)
        
        file.write(toFile: fileName, atomically: true)
        
        return file
    }
    
    func scaleImage(data: NSData, size: CGSize) -> Data{
        let image = UIImage(data: data as Data)
        
        UIGraphicsBeginImageContext(size)
        // 设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        // 绘制改变大小的图片
        image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height) )
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return  UIImageJPEGRepresentation(scaledImage!, 1.0)!
    }
}
