//
//  MoTable.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/29.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit
import Spring
import RealmSwift

class MoTable: UIView, UITableViewDelegate,UITableViewDataSource{
    var moTable: UITableView?
    var cellHeight:CGFloat = 70
    
    var showRow:Int = 0
    var totalRow:Int = 10
    
    var contents: [MoText] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initArticle()
        initShowRow()
        self.moTable = UITableView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), style: UITableViewStyle.Plain)
        self.moTable?.delegate = self
        self.moTable?.dataSource = self
        self.moTable?.registerClass(MoTableCell.self, forCellReuseIdentifier: "moCell")
        self.moTable?.backgroundColor = UIColor.clearColor()
        self.moTable?.userInteractionEnabled = false
        self.moTable?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.addSubview(moTable!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalRow
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MoTableCell = self.moTable?.dequeueReusableCellWithIdentifier("moCell") as! MoTableCell
        cell.position = indexPath.row
        if (indexPath.row >= showRow){
            cell.horizenLine?.frame.size.width = 300
        }
        if (contents[indexPath.row].photos.count != 0){
            var photoPos = contents[indexPath.row].photos.count
            cell.articlePhoto?.image = UIImage(data: contents[indexPath.row].photos[photoPos - 1].photo)
        }
        cell.articlePhoto?.animate()
        cell.date?.text = contents[indexPath.row].date
        cell.date?.animate()
        return cell
    }
    
    
    func drawSeperateLine(time: Int){
        if (time >= Int(self.frame.size.height) / Int(cellHeight) + 1) {
            return
        }else{
            var verticalLine = UIView(frame: CGRectMake(0, CGFloat(time) * cellHeight, 2, 0))
            verticalLine.backgroundColor = UIColor.whiteColor()
            self.addSubview(verticalLine)
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                verticalLine.frame.size.height = self.cellHeight
                }, completion: {(finish) -> Void in
                    if (time < self.showRow){
                        let cell = self.moTable!.cellForRowAtIndexPath(NSIndexPath(forRow: time, inSection: 0)) as! MoTableCell
                        UIView.animateWithDuration(0.5, animations: {
                            cell.horizenLine!.frame.size.width = 300
                            }, completion: nil)
                    }
    
                    self.drawSeperateLine(time + 1)
                    if time == self.showRow - 1{
                        self.moTable?.userInteractionEnabled = true
                    }
            })
        }
    }
    
    func initArticle(){
        contents = []
        let realm = Realm()
        for each in realm.objects(MoText){
            contents.append(each)
        }
        if (contents.count == 0){
            var firstArticle = MoText()
            firstArticle.date = "create new article"
            let firstPhoto = MoPhoto()
            firstPhoto.photo = UIImagePNGRepresentation(UIImage(named: "add"))
            firstArticle.photos.append(firstPhoto)
            firstArticle.id = 0
            realm.write{
                realm.deleteAll()
                realm.add(firstArticle)
            }
            contents.append(firstArticle)
        }
    }
    
    func initShowRow(){
        totalRow = self.contents.count

        var height = CGFloat(totalRow) * cellHeight
        if (height < self.frame.size.height){
            showRow = totalRow
        }
        else {
            showRow = Int(self.frame.size.height) / Int(cellHeight) + 1
        }
    }
    
    func updateArticle(){
        initArticle()
        initShowRow()
        if (totalRow == showRow){
            drawSeperateLine(0)
        }
        (self.superview as! MoDetail).articleNum?.text = "Articles: " + (NSUserDefaults.standardUserDefaults().objectForKey("articleNum") as! String)
        self.moTable?.reloadData()
    }
    
}
