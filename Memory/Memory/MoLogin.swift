//
//  MoLoginError.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MoLoginController: MoBGController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func blurEffect(){
        var blurView = FXBlurView()
        self.MoBGImageView.addSubview(blurView)
        blurView.snp_makeConstraints{(make) -> Void in
            make.centerX.equalTo(0)
            make.centerY.equalTo(0)
            make.width.equalTo(self.MoBGImageView.frame.size.width)
            make.height.equalTo(50)
        }
        blurView.dynamic = true
        blurView.tintColor = UIColor.clearColor()
        self.MoBGImageView.addSubview(blurView)
    }
    
}
