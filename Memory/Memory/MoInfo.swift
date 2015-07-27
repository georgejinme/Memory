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
    }
    
    func initPlaceLabel(){
        urPlace = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        urPlace?.center = CGPointMake(self.frame.size.width / 2, 25 + self.frame.size.width)
        urPlace?.font = UIFont(name: "STHeitiJ-Light", size: 30)
        urPlace?.textColor = UIColor.whiteColor()
        myPlace = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        myPlace?.center = CGPointMake(self.frame.size.width / 2, 75 + self.frame.size.width)
        myPlace?.font = UIFont(name: "STHeitiJ-Light", size: 30)
        myPlace?.textColor = UIColor.whiteColor()
        myPlace?.textAlignment = NSTextAlignment.Right
    }
    
    override func beginAnimate(){
        self.addSubview(personPhoto!)
        personPhoto?.animateNext({
            self.addSubview(self.urPlace!)
            self.urPlace?.text = "You are in " + (NSUserDefaults.standardUserDefaults().objectForKey("urplace") as? String)!
            self.urPlace?.animation = "fadeInLeft"
            self.urPlace?.curve = "easeIn"
            self.urPlace?.duration = 2.4
            self.urPlace?.animateNext({
                var text = NSUserDefaults.standardUserDefaults().objectForKey("myplace") as! String
                if text == (NSUserDefaults.standardUserDefaults().objectForKey("urplace") as! String){
                    text = "I am always with you"
                    
                }else{
                    text = "I am in " + text
                }
                self.myPlace?.text = text
                self.addSubview(self.myPlace!)
                self.myPlace?.animation = "fadeInRight"
                self.myPlace?.curve = "easeIn"
                self.myPlace?.duration = 2.4
                self.myPlace?.animate()
            })
        })
    }
    
    override func removeAnimate(){
        myPlace?.removeFromSuperview()
        urPlace?.removeFromSuperview()
    }
    
}