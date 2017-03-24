//
//  Modal.swift
//  cl
//
//  Created by wujiadong on 16/9/25.
//  Copyright © 2016年 wujiadong. All rights reserved.
//

import Foundation

import UIKit

// Alert/confirm tips etc

class Modal : UIViewController{
    /*
        title: String
        content: String
        sure: () -> Void
    */
    static func alert() -> UIAlertController{
        let Type1 = UIAlertController(title: "你好", message: "fukc u bitch", preferredStyle: UIAlertControllerStyle.alert)
        
        let a1 = UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: {(ath: UIAlertAction) -> Void in
            print("确认")
        })
        
        let a2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: {(ath: UIAlertAction) -> Void in
            print("取消")
        })
        
        Type1.addAction(a2)
        Type1.addAction(a1)
        
        return Type1
    }
    
    // 底部弹出
    static func sheet() -> UIAlertController{
        let Type1 = UIAlertController(title: "你好", message: "fukc u bitch", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let a1 = UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: {(ath: UIAlertAction) -> Void in
            print("确认")
        })
        
        let a2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: {(ath: UIAlertAction) -> Void in
            print("取消")
        })
        
        Type1.addAction(a2)
        Type1.addAction(a1)
        
        return Type1
    }
    
    static func tip(view: UIView) -> UILabel {
        let tip = UILabel()
//        let width = view.bounds.width
        
//        tip.frame = CGRect(x: 0, y: 0, width: width/2, height: 200)
        
//        tip.sizeToFit()
        tip.font = UIFont(name: "Helvetica", size: 12.0)
        tip.text = " 你好啊事发时的符号 "
        // 居中
//        tip.textAlignment = NSTextAlignment.center
        // 设置lineHeight
//        tip.setLineHeight(lineHeight: 20)
        // 设置行数
//        tip.numberOfLines = 1
        // 设置换行
//        tip.lineBreakMode = NSLineBreakMode.byWordWrapping
        // 设置边距
//        tip.layer.borderT
        
        // 居中
        //tip.frame.origin.x = (view.bounds.width - tip.frame.width) / 2
        //tip.frame.origin.y = (view.bounds.height - tip.frame.height) / 2
        
        tip.adjustsFontSizeToFitWidth = true
        tip.backgroundColor = Theme.bgd
        
        // 设置UITextView的边距
//        tip.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // 宽度确定，计算高度， 高度确定计算宽度
        let text:String = tip.text!//获取label的text
        _ = [NSFontAttributeName: tip.font!]//计算label的字体
        var size = CGRect();
        let size2 = CGSize(width: 100, height: 0);//设置label的最大宽度
        
        size = text.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil )
        tip.frame = size//调用计算label宽高的方法
        tip.center = view.center
        tip.layer.addBorder(edge: UIRectEdge.top, color: UIColor.red, thickness: 1)
        
//        let top = NSLayoutConstraint(item: tip, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 60)
//        let bottom = NSLayoutConstraint(item: tip, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 60)
//        let left = NSLayoutConstraint(item: tip, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 60)
//        let right = NSLayoutConstraint(item: tip, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 60)
//        
//        tip.addConstraints([top, bottom, left, traint(
        
        view.addSubview(tip)
        
        tip.layer.transform = CATransform3DMakeScale(10, 10, 1)
        
        UIView.beginAnimations(nil, context: nil)
        
        UIView.setAnimationDuration(0.4)
        
        tip.layer.transform = CATransform3DMakeScale(1, 1, 1)
        
        UIView.commitAnimations()
        
        // 倒计时
//        _ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(Modal.sth), userInfo: nil, repeats: false)
        let fuck = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {(timer: Timer) -> Void in
            print("这是一个山谷去")
            
           
            UIView.animate(withDuration: 0.4, animations: {() -> Void in
                tip.layer.opacity = 0.0
                var trans = CATransform3DIdentity
                trans = CATransform3DRotate(trans, 100, 0, 0, 1)
                trans = CATransform3DScale(trans, 2, 2, 1)
                tip.layer.transform = trans
//                tip.layer.transform = CATransform3DMakeRotation(100, 0, 0, 1)
//                tip.layer.transform = CATransform3DMakeScale(2, 2, 1)
//                tip.layer.transform = CATransform3D(
//                    m11: <#T##CGFloat#>, m12: <#T##CGFloat#>, m13: <#T##CGFloat#>, m14: <#T##CGFloat#>,
//                    m21: <#T##CGFloat#>, m22: <#T##CGFloat#>, m23: <#T##CGFloat#>, m24: <#T##CGFloat#>,
//                    m31: <#T##CGFloat#>, m32: <#T##CGFloat#>, m33: <#T##CGFloat#>, m34: <#T##CGFloat#>,
//                    m41: <#T##CGFloat#>, m42: <#T##CGFloat#>, m43: <#T##CGFloat#>, m44: <#T##CGFloat#>
//                )
            }, completion: {(done: Bool) -> Void in
                tip.removeFromSuperview()
            })
        })
        
        // fire立即执行
//        fuck.fire()
        
        fuck.invalidate()
        return tip
    }
    
    static func sth () {
        print("倒计时")
    }
}


extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count ) )
            self.attributedText = attributeString
        }
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width:thickness, height:self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y:0, width:thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}
