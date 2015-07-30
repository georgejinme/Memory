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

class MoNewArticle: SpringView, UITextViewDelegate, UITextFieldDelegate{
    
    var backGround: UIImageView?
    var topToolBar: UIToolbar?
    
    var titleText: UITextField?
    var dateText: UITextField?
    var contentView: UITextView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
        initImage()
        initToolBar()
        initTextSection()
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
    
    func initTextSection(){
        titleText = UITextField(frame: CGRectMake(0, 40, self.frame.size.width - 10, 50))
        titleText?.center.x = self.frame.size.width / 2
        titleText?.placeholder = "Input your title here..."
        titleText?.delegate = self
        titleText?.setValue(UIColor(red: 210.0/255, green: 210.0/255, blue: 210.0/225, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        titleText?.returnKeyType = UIReturnKeyType.Done
        titleText?.font = UIFont(name: "STHeitiJ-Light", size: 14)
        titleText?.textColor = UIColor.whiteColor()
        self.addSubview(titleText!)
        
        dateText = UITextField(frame: CGRectMake(0, 90, self.frame.size.width - 10, 50))
        dateText?.center.x = self.frame.size.width / 2
        dateText?.placeholder = "Input your date here..."
        dateText?.delegate = self
        dateText?.setValue(UIColor(red: 210.0/255, green: 210.0/255, blue: 210.0/225, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
        dateText?.returnKeyType = UIReturnKeyType.Done
        dateText?.font = UIFont(name: "STHeitiJ-Light", size: 14)
        dateText?.textColor = UIColor.whiteColor()
        self.addSubview(dateText!)
        
        contentView = UITextView(frame: CGRectMake(0, 150, self.frame.size.width, self.frame.size.height - 150))
        contentView?.textColor = UIColor(red: 210.0/255, green: 210.0/255, blue: 210.0/225, alpha: 1)
        contentView?.text = "Input the content here..."
    
        contentView?.delegate = self
        contentView?.font = UIFont(name: "STHeitiJ-Light", size: 16)
        contentView?.backgroundColor = UIColor.clearColor()
        self.addSubview(contentView!)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "Input the content here..."{
            textView.text = ""
            textView.textColor = UIColor.whiteColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == ""{
            textView.textColor = UIColor(red: 210.0/255, green: 210.0/255, blue: 210.0/225, alpha: 1)
            textView.text = "Input the content here..."
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        (self.superview as! MoDetail).uploadPhoto()
    }
    func done(sender: UIBarButtonItem){
        
    }
}