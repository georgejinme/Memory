//
//  MoInfoImage.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/26.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring

class MoInfoImage: SpringView{
    
    var imageEdge:UIImageView?
    var personImageView:UIImageView?
    
    var personImage = UIImage(named: "personDefault")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.animation = "fadeIn"
        self.duration = 2.5
        self.curve = "easeIn"
        initPersonImage()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPersonImage(){
        personImageView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width - 100, self.frame.size.height - 100))
        personImageView?.image = personImage
        personImageView?.center = self.center
        self.addSubview(personImageView!)
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("personImage") == nil){
            var blur = FXBlurView(frame: CGRectMake(0, 0, personImageView!.frame.size.width, personImageView!.frame.size.height))
            blur.center = CGPointMake(personImageView!.frame.size.width / 2, personImageView!.frame.size.height / 2)
            blur.dynamic = true
            blur.blurRadius = 10
            blur.tintColor = UIColor.clearColor()
            self.personImageView!.addSubview(blur)
            
            var tipLabel = UILabel(frame: CGRectMake(0, 0, blur.frame.size.width, 50))
            tipLabel.center = CGPointMake(blur.frame.size.width / 2, blur.frame.size.height / 2)
            tipLabel.text = "Long Press to Upload a photo"
            tipLabel.textColor = UIColor.whiteColor()
            tipLabel.textAlignment = NSTextAlignment.Center
            tipLabel.font = UIFont(name: "STHeitiJ-Light", size: 16)
            blur.addSubview(tipLabel)
            
            var uploadIcon = UIImageView(frame: CGRectMake(0, 0, 30, 30))
            uploadIcon.center = CGPointMake(blur.frame.size.width / 2, blur.frame.size.height / 2 + 30)
            uploadIcon.image = UIImage(named: "uploadIcon")
            blur.addSubview(uploadIcon)
        }
    }
    
}