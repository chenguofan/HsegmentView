//
//  HsegmentView.swift
//  wristBand
//
//  Created by suhengxian on 2021/12/16.
//

import UIKit

typealias HSegmentViewClosure = (_ index:Int)->Void

class HsegmentView: UIView {
    
    var hsegmentViewClosure:HSegmentViewClosure?
    
    var titles:[String]?{
        willSet{
            self.titles = newValue
        }
        didSet{
            //赋值
            guard (self.titles?.count ?? 0 > 0) != false else{
                return
            }
            for sub in self.subviews{
                sub.removeFromSuperview()
            }
            guard let count = self.titles?.count else { return  }
            
            for index in 0...count - 1{
                let btn = UIButton(type: .custom)
                btn.setTitle(self.titles![index], for: .normal)
                btn.setTitle(self.titles![index], for: .selected)
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.setTitleColor(UIColor.white, for: .selected)
                btn.setBackgroundColor(color: UIColor.red, forState: .normal)
                btn.setBackgroundColor(color: UIColor.blue, forState: .selected)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                btn.tag = 100 + index
                self.addSubview(btn)
                
                if index == 0 {
                    btn.isSelected = true
                }
            }
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        let count:Int = self.titles?.count ?? 0
    
        if count > 0{
            let btnWidth = self.frame.size.width/(CGFloat)(count)
            let btnHeight = self.frame.size.height
            
            for index in 0...count - 1 {
                let btn = self.viewWithTag(100 + index)
                btn?.frame = CGRect.init(x:btnWidth * CGFloat(index), y: 0, width: btnWidth, height: btnHeight)
            }
        }
        
        self.layer.cornerRadius = self.frame.size.height/2.0
        self.clipsToBounds = true
        
    }
    
    @objc func btnClick(_ sender:UIButton){
        guard let count = self.titles?.count else { return }
        for index in 0...count - 1 {
            let btn:UIButton = self.viewWithTag(100 + index) as! UIButton
            btn.isSelected = false
        }
        sender.isSelected = true
        self.hsegmentViewClosure?(sender.tag - 100)
        
    }
    
    func clickComplete(hsgmentViewClosure:@escaping HSegmentViewClosure){
        self.hsegmentViewClosure = hsgmentViewClosure
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
