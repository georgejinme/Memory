//
//  MoInfoController.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/23.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoInfo:UIView{
    
    var title : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.title = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, 50))
        self.title!.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.title!.text = "hahaah"
        self.title?.textAlignment = NSTextAlignment.Center
        self.addSubview(self.title!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}