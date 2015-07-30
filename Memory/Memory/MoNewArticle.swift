//
//  MoNewArticle.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/30.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring

class MoNewArticle: SpringView{
    
    var backGround: UIImageView?
    var topToolBar: UIToolbar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
        initImage()
        initToolBar()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initImage(){
        backGround = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        backGround?.image = UIImage(named: "articleBG")
        self.addSubview(backGround!)
        var blur = FXBlurView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        blur.blurRadius = 30
        blur.dynamic = false
        blur.tintColor = UIColor.clearColor()
        self.backGround?.addSubview(blur)
    }
    
    func initToolBar(){
        topToolBar = UIToolbar(frame: CGRectMake(0, 0, self.frame.size.width, 40))
        topToolBar?.barStyle = UIBarStyle.Default
        topToolBar?.barTintColor = UIColor.whiteColor()
        var attributes:NSDictionary = [NSFontAttributeName: UIFont(name: "STHeitiJ-Light", size: 14)!]
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel:")
        cancelButton.tintColor = UIColor.grayColor()
        cancelButton.setTitleTextAttributes(attributes as [NSObject : AnyObject], forState: UIControlState.Normal)
        var uploadButton = UIBarButtonItem(title: "Upload Photos", style: UIBarButtonItemStyle.Plain, target: self, action: "upload:")
        uploadButton.tintColor = UIColor.grayColor()
        uploadButton.setTitleTextAttributes(attributes as [NSObject : AnyObject], forState: UIControlState.Normal)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "done:")
        doneButton.tintColor = UIColor.grayColor()
        doneButton.setTitleTextAttributes(attributes as [NSObject : AnyObject], forState: UIControlState.Normal)
        topToolBar?.items = [cancelButton, flexibleSpace, uploadButton, flexibleSpace, doneButton]
        self.addSubview(topToolBar!)
    }
    
    func cancel(sender: UIBarButtonItem){
        self.animation = "fadeOut"
        self.curve = "easeIn"
        self.duration = 1.6
        self.animateToNext({
            self.removeFromSuperview()
        })
    }
    func upload(sender:UIBarButtonItem){
        
    }
    func done(sender: UIBarButtonItem){
        
    }
}