//
//  Constant.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

func addConstraint(view: UIView, x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat){
    view.snp_makeConstraints{(make) -> Void in
        make.centerX.equalTo(x)
        make.centerY.equalTo(y)
        make.width.equalTo(w)
        make.height.equalTo(h)
    }
}