//
//  MoLoginError.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoLoginController: MoBGController, UITextFieldDelegate, UIGestureRecognizerDelegate{
    
    var blurView = FXBlurView()
    var passwordInput = UITextField()
    
    var beginLoc: CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func blurEffect(){
        blurView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50.0)
        blurView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
        self.view.addSubview(blurView)
        blurView.dynamic = true
        blurView.tintColor = UIColor.clearColor()
        if (FIRST_LOGIN){
            inputPassword("Please Set Your Password. Left Swipe to Confirm")
        }else{
            inputPassword("Please Input Your Password. Left Swipe to Login")
        }
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
        passwordInput.font = UIFont.systemFontOfSize(14)
        passwordInput.frame = CGRectMake(0, 0, self.view.frame.size.width, 50)
        self.blurView.addSubview(passwordInput)
        self.blurView.bringSubviewToFront(passwordInput)
        println(passwordInput.frame)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        passwordInput.resignFirstResponder()
        var touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        self.beginLoc = touch.locationInView(self.view)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        var currLoc = touch.locationInView(self.view)
        var preLoc = touch.previousLocationInView(self.view)
        var offset = CGPointMake(currLoc.x - preLoc.x, currLoc.y - preLoc.y)
        self.blurView.center = CGPointMake(self.blurView.center.x + offset.x, self.blurView.center.y)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        var endLoc = touch.locationInView(self.view)
        if (beginLoc.x - endLoc.x > 50){
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.blurView.center = CGPointMake(0 - self.blurView.frame.size.width / 2, self.blurView.center.y)
            }, completion: nil)
        }else{
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.blurView.center = CGPointMake(self.view.frame.size.width / 2, self.blurView.center.y)
                }, completion: nil)
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        passwordInput.resignFirstResponder()
        return true
    }
    
}









