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
    
    var timeTips: SpringLabel?
    var memoryTime: SpringLabel?
    var memoryTimeSecond = 0
    var memoryTimeString = "a long time..."
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPhoto()
        initPlaceLabel()
        initTimeLabel()
        calculateTime()
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
    
    func initTimeLabel(){
        timeTips = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        timeTips?.center = CGPointMake(self.frame.size.width / 2, 125 + self.frame.size.width)
        timeTips?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        timeTips?.textColor = UIColor.whiteColor()
        timeTips?.text = "Our memory has lasted for..."
        timeTips?.textAlignment = NSTextAlignment.Center
        
        memoryTime = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 60))
        memoryTime?.center = CGPointMake(self.frame.size.width / 2, 175 + self.frame.size.width)
        memoryTime?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        memoryTime?.textColor = UIColor.yellowColor()
        memoryTime?.text = memoryTimeString
        memoryTime?.textAlignment = NSTextAlignment.Center
        
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
                self.myPlace?.animateNext({
                    self.addSubview(self.timeTips!)
                    self.timeTips?.animation = "fadeIn"
                    self.timeTips?.curve = "easeIn"
                    self.timeTips?.duration = 2.5
                    self.timeTips?.animateNext({
                        self.addSubview(self.memoryTime!)
                        self.memoryTime?.animation = "fadeIn"
                        self.memoryTime?.curve = "easeIn"
                        self.memoryTime?.duration = 2.5
                        self.memoryTime?.animate()
                    })
                })
            })
        })
    }
    
    override func removeAnimate(){
        myPlace?.removeFromSuperview()
        urPlace?.removeFromSuperview()
    }
    
    func calculateTime(){
        var date = NSDate()
        var format = NSDateFormatter()
        format.dateFormat = "yyyyMMdd"
        var dateString = format.stringFromDate(date)
        var beginTimeString = NSUserDefaults.standardUserDefaults().objectForKey("memoryBeginTime") as! String
        var beginDate = format.dateFromString(beginTimeString)
        if (beginDate == nil){
            var alert = UIAlertView(title: "Warning", message: "Invaild date format. Please input the date with format 'YYYYMMDD' in setting view", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            memoryTimeSecond = NSInteger(date.timeIntervalSinceDate(beginDate!))
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
        }
    }
    func updateTime(sender:NSTimer){
        ++memoryTimeSecond
        var totalSecond = memoryTimeSecond
        var second = String(totalSecond % 60)
        totalSecond /= 60
        var minute = String(totalSecond % 60)
        totalSecond /= 60
        var hour = String(totalSecond % 24)
        totalSecond /= 24
        var day = String(totalSecond)
        memoryTimeString = day + "days " + hour + "hours " + minute + "mins " + second + "s"
        memoryTime?.text = memoryTimeString
        
        if(memoryTimeSecond % 2 == 0){
            memoryTime?.twinkle()
        }
    }
}