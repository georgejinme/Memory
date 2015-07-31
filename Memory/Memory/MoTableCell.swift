//
//  MoTableCell.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/29.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring

class MoTableCell: UITableViewCell{
    var position = 0
    
    var horizenLine: UIView?
    var articlePhoto: SpringImageView?
    var date: SpringLabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        horizenLine = UIView(frame: CGRectMake(0, self.frame.size.height + 25, 0, 1))
        horizenLine?.backgroundColor = UIColor.whiteColor()
        self.addSubview(horizenLine!)
        
        articlePhoto = SpringImageView(frame: CGRectMake(0, 0, self.frame.size.height + 25, self.frame.size.height + 25))
        articlePhoto?.animation = "fadeIn"
        articlePhoto?.curve = "easeIn"
        articlePhoto?.duration = 2.5
        articlePhoto?.userInteractionEnabled = true
        articlePhoto?.multipleTouchEnabled = true
        var photoTapGesture = UITapGestureRecognizer(target: self, action: "photo:")
        photoTapGesture.numberOfTapsRequired = 1
        articlePhoto?.addGestureRecognizer(photoTapGesture)
        self.addSubview(articlePhoto!)
        
        date = SpringLabel(frame: CGRectMake(self.frame.size.height + 30, 0, self.frame.size.width - self.frame.size.height, 50))
        date?.center.y = (self.frame.size.height + 25) / 2
        date?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        date?.textColor = UIColor.whiteColor()
        date?.animation = "fadeIn"
        date?.curve = "easeIn"
        date?.duration = 2.5
        date?.userInteractionEnabled = true
        date?.multipleTouchEnabled = true
        var dateTapGesture = UITapGestureRecognizer(target: self, action: "date:")
        dateTapGesture.numberOfTapsRequired = 1
        date?.addGestureRecognizer(dateTapGesture)
        self.addSubview(date!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func photo(sender: UITapGestureRecognizer){
        (self.superview?.superview?.superview?.superview as! MoDetail).initArticlePhotoView(self.position)
    }
    
    func date(sender: UITapGestureRecognizer){
        (self.superview?.superview?.superview?.superview as! MoDetail).initNewArticleView(self.position)
    }
    
    
}