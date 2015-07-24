//
//  MoLogin.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/25.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

var passwordInput = UITextField()

func initLoginView(view: UIView) -> FXBlurView{
    var loginBlurView = FXBlurView(frame: CGRectMake(0, 0, view.frame.size.width, 50.0))
    loginBlurView.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2)
    loginBlurView.dynamic = true
    loginBlurView.tintColor = UIColor.clearColor()
    return loginBlurView
}

func initInputPassword(loginBlurView: FXBlurView, text: String){
    passwordInput.backgroundColor = UIColor.clearColor()
    passwordInput.borderStyle = UITextBorderStyle.None
    passwordInput.delegate = MoLoginController()
    passwordInput.textAlignment = NSTextAlignment.Center
    passwordInput.placeholder = text
    passwordInput.secureTextEntry = true
    passwordInput.clearButtonMode = UITextFieldViewMode.WhileEditing
    passwordInput.returnKeyType = UIReturnKeyType.Done
    passwordInput.font = UIFont.systemFontOfSize(14)
    passwordInput.frame = CGRectMake(0, 0, loginBlurView.frame.size.width, 50)
    loginBlurView.addSubview(passwordInput)
}