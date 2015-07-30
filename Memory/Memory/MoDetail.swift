//
//  MoDetail.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/28.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring
import RealmSwift

protocol MoNewArticleDelegate{
    func uploadButtonClick()
}

class MoDetail: MoView{
    
    var spaceLabelTip: SpringLabel?
    var articleNum: SpringLabel?
    var photoNum: SpringLabel?
    var wordNum: SpringLabel?
    
    var detailTable: MoTable?
    var articles:[MoText] = []
    var firstArticle = MoText()
    
    var newArticles:MoNewArticle?
    
    var delegate:MoNewArticleDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initArticle()
        initSpaceLabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSpaceLabel(){
        var store = NSUserDefaults.standardUserDefaults()
        
        spaceLabelTip = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        spaceLabelTip?.center = CGPointMake(self.frame.size.width / 2, 25)
        spaceLabelTip?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        spaceLabelTip?.textColor = UIColor.whiteColor()
        spaceLabelTip?.text = "Your memory space included "
        
        articleNum = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        articleNum?.center = CGPointMake(self.frame.size.width / 2, 75)
        articleNum?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        articleNum?.textColor = UIColor.whiteColor()
        articleNum?.text = "Articles: " + ((store.objectForKey("articleNum") ?? String(0)) as! String)
        articleNum?.textAlignment = NSTextAlignment.Right
        
        photoNum = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        photoNum?.center = CGPointMake(self.frame.size.width / 2, 125)
        photoNum?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        photoNum?.textColor = UIColor.whiteColor()
        photoNum?.text = "Photos: " + ((store.objectForKey("photoNum") ?? String(0)) as! String)
        photoNum?.textAlignment = NSTextAlignment.Right
        
        wordNum = SpringLabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 50))
        wordNum?.center = CGPointMake(self.frame.size.width / 2, 175)
        wordNum?.font = UIFont(name: "STHeitiJ-Light", size: 24)
        wordNum?.textColor = UIColor.whiteColor()
        wordNum?.text = "Words: " + ((store.objectForKey("wordNum") ?? String(0)) as! String)
        wordNum?.textAlignment = NSTextAlignment.Right
    }
    
    func drawLineSperator(start: CGFloat, end: CGFloat, y: CGFloat, duration: NSTimeInterval){
        var line = UIView(frame: CGRectMake(start, y, 0, 2))
        line.backgroundColor = UIColor.whiteColor()
        self.addSubview(line)
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            line.frame.size.width = 20
            }, completion:{(finish) -> Void in
                self.detailTable?.drawSeperateLine(0)
        })
        UIView.animateWithDuration(duration - 0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            line.frame.size.width = end - start
        }, completion: nil)
        
    }
    
    func initDetailTable(){
        detailTable = MoTable(frame: CGRectMake(40, 200, self.frame.size.width - 20, self.frame.size.height - 200), c: articles)
        self.addSubview(detailTable!)
    }
    
    func initNewArticleView(pos: Int){
        newArticles = MoNewArticle(frame: CGRectMake(40, 40, self.frame.size.width - 80, self.frame.size.height - 80))
        newArticles?.animation = "fadeInUp"
        newArticles?.curve = "easeIn"
        newArticles?.duration = 1.6
        self.addSubview(newArticles!)
        newArticles?.titleText?.text = articles[pos].title
        newArticles?.dateText?.text = articles[pos].date
        newArticles?.contentView?.text = articles[pos].content
        newArticles?.animate()
    }
    
    func uploadPhoto(){
        delegate?.uploadButtonClick()
    }
    
    
    
    override func beginAnimate() {
        self.addSubview(spaceLabelTip!)
        spaceLabelTip?.animation = "fadeInLeft"
        spaceLabelTip?.curve = "easeIn"
        spaceLabelTip?.duration = 2.4
        spaceLabelTip?.animateNext({
            self.addSubview(self.articleNum!)
            self.articleNum?.animation = "fadeInRight"
            self.articleNum?.curve = "easeIn"
            self.articleNum?.duration = 1.5
            self.articleNum?.animate()
            
            self.addSubview(self.photoNum!)
            self.photoNum?.animation = "fadeInRight"
            self.photoNum?.curve = "easeIn"
            self.photoNum?.duration = 1.5
            self.photoNum?.animate()
            
            self.addSubview(self.wordNum!)
            self.wordNum?.animation = "fadeInRight"
            self.wordNum?.curve = "easeIn"
            self.wordNum?.duration = 1.5
            self.wordNum?.animate()
            
            self.drawLineSperator(0, end: self.frame.size.width, y: 200, duration: 1.5)
            self.initDetailTable()
        })
    }
    
    func initArticle(){
        let realm = Realm()
        
        firstArticle.date = "create new article"
        let firstPhoto = MoPhoto()
        firstPhoto.photo = UIImagePNGRepresentation(UIImage(named: "add"))
        firstArticle.photos.append(firstPhoto)
        
        if (FIRST_LOGIN){
            realm.write{
                realm.add(self.firstArticle)
            }
            articles.append(firstArticle)
        }else{
            for each in realm.objects(MoText){
                articles.append(each)
            }
        }
    }
}






