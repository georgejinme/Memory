//
//  MoInfoController.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/23.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Twinkle
import Spring

class MoInfo:MoView{
    
    var personPhoto: MoInfoImage?
    var myPlace: SpringLabel?
    var urPlace: SpringLabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPhoto()
        initPlaceLabel()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhoto(){
        personPhoto = MoInfoImage(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.width))
        self.addSubview(personPhoto!)
    }
    
    func initPlaceLabel(){
        myPlace = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        myPlace?.center = CGPointMake(self.frame.size.width / 2, 25 + self.frame.size.width)
        urPlace = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        urPlace?.center = CGPointMake(self.frame.size.width / 2, 75 + self.frame.size.width)
        myPlace?.font = UIFont(name: "STHeitiJ-Light", size: 36)
        myPlace?.textColor = UIColor.whiteColor()
        urPlace?.font = UIFont(name: "STHeitiJ-Light", size: 36)
        urPlace?.textColor = UIColor.whiteColor()
        urPlace?.textAlignment = NSTextAlignment.Right
    }
    
    override func beginAnimate(){
        self.addSubview(myPlace!)
        myPlace?.text = NSUserDefaults.standardUserDefaults().objectForKey("myplace") as? String
        myPlace?.animation = "fadeInLeft"
        myPlace?.curve = "easeIn"
        myPlace?.duration = 2.4
        myPlace?.animateNext({
            self.urPlace?.text = NSUserDefaults.standardUserDefaults().objectForKey("urplace") as? String
            self.addSubview(self.urPlace!)
            self.urPlace?.animation = "fadeInRight"
            self.urPlace?.curve = "easeIn"
            self.urPlace?.duration = 2.4
            self.urPlace?.animate()
        })
    }
    
    override func removeAnimate(){
        myPlace?.removeFromSuperview()
        urPlace?.removeFromSuperview()
    }
    
}