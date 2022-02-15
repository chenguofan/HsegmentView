//
//  ViewController.swift
//  HsegmentView
//
//  Created by suhengxian on 2022/2/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hsegmentView = HsegmentView.init(frame: CGRect.init(x:UIScreen.main.bounds.size.width - 170, y:100 + 40, width: 150, height: 40))
        hsegmentView.titles = ["周","月","年"];
        hsegmentView.clickComplete { index in
            if index == 0{
                print("hello world1")
            }
            
            if index == 1{
                print("hello world2")
            }
            
            if index == 2{
                print("hello world3")
            }
        }
        self.view.addSubview(hsegmentView)
        
    }


}

