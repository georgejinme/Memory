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
    
    var myPlace: UILabel?
    var urPlace: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPlaceLabel()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPlaceLabel(){
        myPlace = UILabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        myPlace?.center = CGPointMake(self.frame.size.width / 2, 50)
        urPlace = UILabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        urPlace?.center = CGPointMake(self.frame.size.width / 2, 125)
        
        myPlace?.text = "我在上海"
        myPlace?.font = UIFont(name: "Helvetica", size: 36)
        myPlace?.textColor = UIColor.whiteColor()
        urPlace?.text = "你就在我身边"
        urPlace?.font = UIFont(name: "Helvetica", size: 36)
        urPlace?.textColor = UIColor.whiteColor()
        
        self.addSubview(myPlace!)
        self.addSubview(urPlace!)
        
    }
}