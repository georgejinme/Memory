//
//  MoSetUp.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/25.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

var urPlaceSetUp = UITextField()
var myPlaceSetUp = UITextField()
var timeSetUp = UITextField()

func initSetUpView(view: UIView) -> FXBlurView{
    var initSetUpView = FXBlurView(frame: CGRectMake(0, 0, view.frame.size.width, 150.0))
    initSetUpView.center = CGPointMake(view.frame.size.width * 3 / 2, view.frame.size.height / 2)
    initSetUpView.dynamic = true
    initSetUpView.tintColor = UIColor.clearColor()
    return initSetUpView
}

func initMyPlace(setUpBlurView: FXBlurView, text: String){
    myPlaceSetUp.backgroundColor = UIColor.clearColor()
    myPlaceSetUp.borderStyle = UITextBorderStyle.None
    myPlaceSetUp.delegate = MoLoginController()
    myPlaceSetUp.textAlignment = NSTextAlignment.Center
    myPlaceSetUp.placeholder = text
    myPlaceSetUp.secureTextEntry = true
    myPlaceSetUp.clearButtonMode = UITextFieldViewMode.WhileEditing
    myPlaceSetUp.returnKeyType = UIReturnKeyType.Done
    myPlaceSetUp.font = UIFont.systemFontOfSize(14)
    myPlaceSetUp.frame = CGRectMake(0, 0, setUpBlurView.frame.size.width, 50)
    setUpBlurView.addSubview(myPlaceSetUp)
}

func initUrPlace(setUpBlurView: FXBlurView, text: String){
    urPlaceSetUp.backgroundColor = UIColor.clearColor()
    urPlaceSetUp.borderStyle = UITextBorderStyle.None
    urPlaceSetUp.delegate = MoLoginController()
    urPlaceSetUp.textAlignment = NSTextAlignment.Center
    urPlaceSetUp.placeholder = text
    urPlaceSetUp.secureTextEntry = true
    urPlaceSetUp.clearButtonMode = UITextFieldViewMode.WhileEditing
    urPlaceSetUp.returnKeyType = UIReturnKeyType.Done
    urPlaceSetUp.font = UIFont.systemFontOfSize(14)
    urPlaceSetUp.frame = CGRectMake(0, 50, setUpBlurView.frame.size.width, 50)
    setUpBlurView.addSubview(urPlaceSetUp)
}



func initMemoryTime(setUpBlurView: FXBlurView, text: String){
    timeSetUp.backgroundColor = UIColor.clearColor()
    timeSetUp.borderStyle = UITextBorderStyle.None
    timeSetUp.delegate = MoLoginController()
    timeSetUp.textAlignment = NSTextAlignment.Center
    timeSetUp.placeholder = text
    timeSetUp.secureTextEntry = true
    timeSetUp.clearButtonMode = UITextFieldViewMode.WhileEditing
    timeSetUp.returnKeyType = UIReturnKeyType.Done
    timeSetUp.font = UIFont.systemFontOfSize(14)
    timeSetUp.frame = CGRectMake(0, 100, setUpBlurView.frame.size.width, 50)
    setUpBlurView.addSubview(timeSetUp)
}

