//
//  Exam.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/27.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit
import CoreData

class Exam: NSObject {
    var time : Date!
    var title : String!
    var timeStr : String!
    
    init(_time : String, _title : String, _timeStr: String) {
        let fmt = DateFormatter();
        let zone = TimeZone(identifier: "Asia/Shanghai")
        fmt.timeZone = zone!
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        time = fmt.date(from: _time)!
        title = _title
        timeStr = _timeStr
    }
    
    init(dat : ExamData) {
        time = dat.time
        title = dat.title
        timeStr = dat.timeStr
    }
    
    func save() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "ExamData", in: managedObectContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        person.setValue(time, forKey: "time")
        person.setValue(title, forKey: "title")
        person.setValue(timeStr, forKey: "timeStr")
        
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
    }
    
}
