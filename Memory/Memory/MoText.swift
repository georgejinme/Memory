//
//  MoText.swift
//  Memory
//
//  Created by 钩钩么么哒 on 15/7/28.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import Foundation
import RealmSwift

class MoText: Object{
    dynamic var title = ""
    dynamic var date = ""
    dynamic var wordNum = 0
    dynamic var content = ""
    dynamic var photos: [MoPhoto] = []
}