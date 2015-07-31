//
//  MoArticlePhoto.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/31.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring


class MoArticlePhoto: SpringView, PhotoStackViewDelegate, PhotoStackViewDataSource{
    
    var photos = [UIImage(named: "BACKGROUND")]
    var photoData: [NSData] = []
    var ps: PhotoStackView?
    
    init(frame: CGRect, data: [NSData]) {
        super.init(frame: frame)
        photoData = data
        initPhotoAndBG()
        ps = PhotoStackView(frame: CGRectMake(0, 0, 120, 120))
        ps?.delegate = self
        ps?.dataSource = self
        ps?.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addSubview(ps!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhotoAndBG(){
        var imageView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        imageView.image = UIImage(named: "BACKGROUND")
        self.addSubview(imageView)
        var blur = FXBlurView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        blur.dynamic = false
        blur.blurRadius = 10
        blur.tintColor = UIColor.clearColor()
        imageView.addSubview(blur)
        
        photos.removeAll(keepCapacity: false)
        for each in photoData{
            photos.append(UIImage(data: each)!)
        }
        //ps?.reloadData()
    }
    
    func numberOfPhotosInStackView(stackView: PhotoStackView) -> Int {
        return photos.count
    }
    func stackView(stackView: PhotoStackView, imageAtIndex index: Int) -> UIImage {
        return photos[index]!
    }
    func stackView(stackView: PhotoStackView, sizeOfPhotoAtIndex index: Int) -> CGSize {
        return CGSizeMake(self.frame.size.width, self.frame.size.width)
    }
    
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        if touch.locationInView(self).y < (self.frame.size.height / 2 - self.frame.size.width / 2) || touch.locationInView(self).y > (self.frame.size.height / 2 + self.frame.size.width / 2){
            self.animation = "fadeOut"
            self.curve = "easeIn"
            self.duration = 1.6
            self.animateToNext({
                self.removeFromSuperview()
            })
        }
    }
    
}