//
//  MoLoginError.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoLoginController: MoBGController, UITextFieldDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MoInfoPhotoDelegate{
    
    var loginBlurView: FXBlurView?
    var setUpBlurView: FXBlurView?
    var infoView: MoInfo?
    
    var beginLoc: CGPoint = CGPoint()
    
    var loginRequest: Bool = false
    var setUping:Bool = false
    
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
        var loginPlaceHolder = ""
        loginBlurView = initLoginView(self.view)
        self.view.addSubview(loginBlurView!)
        views.append(loginBlurView!)
        if (FIRST_LOGIN){
            loginPlaceHolder = "Please Set Your Password. Left Swipe to Confirm"
        }else{
            loginPlaceHolder = "Please Input Your Password. Left Swipe to Login"
        }
        initInputPassword(loginBlurView!, loginPlaceHolder)
        passwordInput.delegate = self
        
        if (FIRST_LOGIN){
            setUpBlurView = initSetUpView(self.view)
            self.view.addSubview(setUpBlurView!)
            views.append(setUpBlurView!)
            initMyPlace(setUpBlurView!, "Where am I?")
            initUrPlace(setUpBlurView!, "Where are you?")
            initMemoryTime(setUpBlurView!, "When did your memory begin?")
            myPlaceSetUp.delegate = self
            urPlaceSetUp.delegate = self
            timeSetUp.delegate = self
        }
        
        infoView = MoInfo(frame: self.view.bounds)
        infoView!.center = CGPointMake(self.view.frame.size.width * (CGFloat(2 * views.count + 1) / 2), self.view.frame.size.height / 2)
        infoView?.personPhoto?.delegate = self
        self.view.addSubview(infoView!)
        views.append(infoView!)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        passwordInput.resignFirstResponder()
        myPlaceSetUp.resignFirstResponder()
        urPlaceSetUp.resignFirstResponder()
        timeSetUp.resignFirstResponder()
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
        textField.resignFirstResponder()
        return true
    }
    
    func login() -> String{
        loginRequest = false
        if (FIRST_LOGIN){
            if ((passwordInput.text as NSString).length > 4){
                NSUserDefaults.standardUserDefaults().setObject(passwordInput.text, forKey: "password")
                println("set password")
                return "success"
            }else{
                println("password too short")
                passwordInput.text = ""
                passwordInput.placeholder = "Your password must be longer than 4 characters."
                return "fail"
            }
        }else{
            if (passwordInput.text != NSUserDefaults.standardUserDefaults().objectForKey("password") as? String){
                println("login fail")
                passwordInput.text = ""
                passwordInput.placeholder = "wrong password."
                return "fail"
            }else{
                LOGINED = true
                println("login success")
                return "success"
            }
        }
    }
    
    func setUp(){
        var store = NSUserDefaults.standardUserDefaults()
        store.setObject(urPlaceSetUp.text, forKey: "urplace")
        store.setObject(myPlaceSetUp.text, forKey: "myplace")
        store.setObject(timeSetUp.text, forKey: "memoryBeginTime")
        setUping = true
        println("set up done!")
    }
    
    //---------------------------------info Image-----------------------------------
    func doubleClickAction() {
        var actionSheet = UIAlertController(title: "Source", message: "Please choose a source", preferredStyle: UIAlertControllerStyle.ActionSheet)
        var camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:{(action) -> Void in
            self.pickPhotoFrom("camera")
        })

        var album = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.pickPhotoFrom("album")
        })
        var cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        actionSheet.addAction(camera)
        actionSheet.addAction(album)
        actionSheet.addAction(cancel)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func pickPhotoFrom(type: String){
        var picker = UIImagePickerController()
        picker.delegate = self
        if (type == "camera"){
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.showsCameraControls = true
            picker.cameraViewTransform = CGAffineTransformMakeScale(1.5, 1.5)
        }else{
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        infoView?.personPhoto?.blur?.removeFromSuperview()
        infoView?.personPhoto?.personImageView?.image = image
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        var imageData = NSKeyedArchiver.archivedDataWithRootObject(image)
        NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "personImage")
    }
    
}









