//
//  MoLoginError.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoLoginController: MoBGController, UITextFieldDelegate{
    
    var blurView = FXBlurView()
    var passwordInput = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffect()
        inputPassword("请设置账号密码, 右划确认")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func blurEffect(){
        self.MoBGImageView.addSubview(blurView)
        addConstraint(blurView, 0.0, 0.0, self.MoBGImageView.frame.size.width, 50.0)
        blurView.dynamic = false
        blurView.tintColor = UIColor.clearColor()
    }
    
    func inputPassword(text: String){
        passwordInput.backgroundColor = UIColor.clearColor()
        passwordInput.borderStyle = UITextBorderStyle.None
        passwordInput.delegate = self
        passwordInput.textAlignment = NSTextAlignment.Center
        passwordInput.placeholder = text
        passwordInput.secureTextEntry = true
        passwordInput.clearButtonMode = UITextFieldViewMode.WhileEditing
        passwordInput.returnKeyType = UIReturnKeyType.Done
        self.view.addSubview(passwordInput)
        self.view.bringSubviewToFront(passwordInput)
        addConstraint(passwordInput, 0.0, 0.0, self.view.frame.size.width, 50.0)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        passwordInput.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        passwordInput.resignFirstResponder()
        return true
    }
}
