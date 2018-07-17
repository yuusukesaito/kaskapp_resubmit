//
//  Task.swift
//  taskapp
//
//  Created by 理化学Mac on 2018/07/14.
//  Copyright © 2018年 yuusukesaito. All rights reserved.
//

import RealmSwift

class Task: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var contents = ""
    @objc dynamic var date = Date()
    
    //String型のcategoryを追加
    @objc dynamic var category = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
