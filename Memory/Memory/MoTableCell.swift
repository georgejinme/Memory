//
//  MoTableCell.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/29.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoTableCell: UITableViewCell{
    
    var horizenLine: UIView?
    var drawn: Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        horizenLine = UIView(frame: CGRectMake(0, self.frame.size.height + 25, 0, 1))
        horizenLine?.backgroundColor = UIColor.whiteColor()
        self.addSubview(horizenLine!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}