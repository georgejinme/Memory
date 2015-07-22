//
//  MoMainController.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/22.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import UIKit

class MoBGController: UIViewController{
    
    var MoBGImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initImage(){
        self.MoBGImageView.frame = self.view.bounds
        self.MoBGImageView.image = UIImage(named: "BACKGROUND")
        self.view = MoBGImageView
    }
}
