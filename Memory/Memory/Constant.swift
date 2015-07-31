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

var FIRST_LOGIN:Bool = false
var LOGINED: Bool = false
var SETTING:Bool = false