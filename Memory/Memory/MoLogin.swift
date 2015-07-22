//
//  MoLoginError.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class MoLoginController: MoBGController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffect()
        MoTouchIDLogin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initLogo(){
        
    }
    
    func MoTouchIDLogin(){
        let touchID = LAContext()
        let authError: NSErrorPointer = NSErrorPointer()
        if touchID.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: authError) {
            touchID.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Secret is the king.", reply: {(success, error) in
                if success{
                    println("login success")
                }else{
                    println(error)
                    
                }
            })
        }
    }
    
    func blurEffect(){
        let blurView = FXBlurView(frame: self.MoBGImageView.bounds)
        blurView.dynamic = false
        blurView.tintColor = UIColor.clearColor()
        blurView.blurRadius = 40
        self.MoBGImageView.addSubview(blurView)
    }
}
