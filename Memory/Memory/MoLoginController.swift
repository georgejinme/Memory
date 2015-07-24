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
    
    var loginBlurView: FXBlurView?
    var setUpBlurView: FXBlurView?
    var infoView: MoInfo?
    
    var passwordInput = UITextField()
    
    var beginLoc: CGPoint = CGPoint()
    
    var loginRequest: Bool = false
    var setUping:Bool = false
    var mainPage:Bool = false
    
    var views: [UIView] = []
    var currentView = 0
    var oldView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        loginBlurView = FXBlurView(frame: CGRectMake(0, 0, self.view.frame.size.width, 50.0))
        loginBlurView!.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
        self.view.addSubview(loginBlurView!)
        loginBlurView!.dynamic = true
        loginBlurView!.tintColor = UIColor.clearColor()
        views.append(loginBlurView!)
        if (FIRST_LOGIN){
            inputPassword("Please Set Your Password. Left Swipe to Confirm")
        }else{
            inputPassword("Please Input Your Password. Left Swipe to Login")
        }
        
        if (FIRST_LOGIN){
            setUpBlurView = FXBlurView(frame: CGRectMake(0, 0, self.view.frame.size.width, 150.0))
            setUpBlurView!.center = CGPointMake(self.view.frame.size.width * 3 / 2, self.view.frame.size.height / 2)
            self.view.addSubview(setUpBlurView!)
            setUpBlurView!.dynamic = true
            setUpBlurView!.tintColor = UIColor.clearColor()
            views.append(setUpBlurView!)
        }
        
        infoView = MoInfo(frame: self.view.bounds)
        infoView!.center = CGPointMake(self.view.frame.size.width * (CGFloat(2 * views.count + 1) / 2), self.view.frame.size.height / 2)
        self.view.addSubview(infoView!)
        views.append(infoView!)
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
        self.loginBlurView!.addSubview(passwordInput)
        self.loginBlurView!.bringSubviewToFront(passwordInput)
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
        self.views[currentView].center = CGPointMake(self.views[currentView].center.x + offset.x, self.views[currentView].center.y)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        var endLoc = touch.locationInView(self.view)
       
        var moveOrNot = moveJudge(self.beginLoc, end: endLoc)
        var loginRes = ""
        
        if  moveOrNot == "left"{
            if views[oldView] == loginBlurView{
                loginRes = login()
                if loginRes == "fail"{
                    currentView = 0
                }
            }else if views[oldView] == setUpBlurView{
                setUp()
            }
        }
        
        if (moveOrNot != "not move" && loginRes != "fail"){
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.views[self.oldView].center = CGPointMake(-1 * self.view.center.x, self.views[self.oldView].center.y)
                }, completion: nil)
        }
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.views[self.currentView].center = CGPointMake(self.view.center.x, self.views[self.currentView].center.y)
            }, completion: nil)
        
        if (moveOrNot != "not move"){
            if (loginRes == "success"){
                loginRes = "not use"
                self.views.removeAtIndex(0)
                oldView = 0
                currentView = 0
            }else if (setUping){
                self.views.removeAtIndex(0)
                oldView = 0
                currentView = 0
            }
        }
        
        if (moveOrNot != "not move" && views[oldView] != loginBlurView && views[currentView] != loginBlurView && views[oldView] != setUpBlurView && views[currentView] != setUpBlurView){
            (self.views[oldView] as! MoView).removeAnimate()
            (self.views[currentView] as! MoView).beginAnimate()
        }
        
    }
    
    func moveJudge(start: CGPoint, end: CGPoint) -> String{
        if (end.x - start.x > 50){
            if currentView > 0{
                oldView = currentView
                currentView -= 1
                return "right"
            }
            else {return "not move"}
        }else if (end.x - start.x < -50){
            if currentView < self.views.count - 1{
                oldView = currentView
                currentView += 1
                return "left"
            }
            else {return "not move"}
        }else{
            return "not move"
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        passwordInput.resignFirstResponder()
        return true
    }
    
    func login() -> String{
        loginRequest = false
        if (FIRST_LOGIN){
            if ((self.passwordInput.text as NSString).length > 4){
                NSUserDefaults.standardUserDefaults().setObject(self.passwordInput.text, forKey: "password")
                println("set password")
                return "success"
            }else{
                println("password too short")
                self.passwordInput.text = ""
                self.passwordInput.placeholder = "Your password must be longer than 4 characters."
                return "fail"
            }
        }else{
            if (self.passwordInput.text != NSUserDefaults.standardUserDefaults().objectForKey("password") as? String){
                println("login fail")
                self.passwordInput.text = ""
                self.passwordInput.placeholder = "wrong password."
                return "fail"
            }else{
                LOGINED = true
                println("login success")
                return "success"
            }
        }
    }
    
    func setUp(){
        setUping = true
        
    }
}









