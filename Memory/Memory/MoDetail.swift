//
//  MoDetail.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/28.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring

class MoDetail: MoView{
    
    var spaceLabelTip: SpringLabel?
    var articleNum: SpringLabel?
    var photoNum: SpringLabel?
    var wordNum: SpringLabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSpaceLabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSpaceLabel(){
        var store = NSUserDefaults.standardUserDefaults()
        
        spaceLabelTip = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        spaceLabelTip?.center = CGPointMake(self.frame.size.width / 2, 25)
        spaceLabelTip?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        spaceLabelTip?.textColor = UIColor.whiteColor()
        spaceLabelTip?.text = "Your memory space included "
        
        articleNum = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        articleNum?.center = CGPointMake(self.frame.size.width / 2, 75)
        articleNum?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        articleNum?.textColor = UIColor.whiteColor()
        articleNum?.text = "Articles: " + ((store.objectForKey("articleNum") ?? String(0)) as! String)
        articleNum?.textAlignment = NSTextAlignment.Right
        
        photoNum = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        photoNum?.center = CGPointMake(self.frame.size.width / 2, 125)
        photoNum?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        photoNum?.textColor = UIColor.whiteColor()
        photoNum?.text = "Photos: " + ((store.objectForKey("photoNum") ?? String(0)) as! String)
        photoNum?.textAlignment = NSTextAlignment.Right
        
        wordNum = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        wordNum?.center = CGPointMake(self.frame.size.width / 2, 175)
        wordNum?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        wordNum?.textColor = UIColor.whiteColor()
        wordNum?.text = "Words: " + ((store.objectForKey("wordNum") ?? String(0)) as! String)
        wordNum?.textAlignment = NSTextAlignment.Right
    }
    
    
    override func beginAnimate() {
        self.addSubview(spaceLabelTip!)
        spaceLabelTip?.animation = "fadeInLeft"
        spaceLabelTip?.curve = "easeIn"
        spaceLabelTip?.duration = 2.4
        spaceLabelTip?.animateNext({
            self.addSubview(self.articleNum!)
            self.articleNum?.animation = "fadeInRight"
            self.articleNum?.curve = "easeIn"
            self.articleNum?.duration = 1.5
            self.articleNum?.animate()
            
            self.addSubview(self.photoNum!)
            self.photoNum?.animation = "fadeInRight"
            self.photoNum?.curve = "easeIn"
            self.photoNum?.duration = 1.5
            self.photoNum?.animate()
            
            self.addSubview(self.wordNum!)
            self.wordNum?.animation = "fadeInRight"
            self.wordNum?.curve = "easeIn"
            self.wordNum?.duration = 1.5
            self.wordNum?.animate()
        })
    }
}






