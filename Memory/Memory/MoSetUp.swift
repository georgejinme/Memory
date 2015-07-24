//
//  MoSetUp.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/25.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoSetUp: MoView{
    
    var blur = FXBlurView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        blur.frame = self.bounds
        blur.tintColor = UIColor.clearColor()
        self.addSubview(blur)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginAnimate(){
        
    }
    
    override func removeAnimate(){
        
    }
    
}