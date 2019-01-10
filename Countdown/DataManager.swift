//
//  DataManager.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/28.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    static func getData() -> [Exam] {
        var ret = [Exam]()
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExamData")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                for it in results {
                    ret.append(Exam(dat: it as! ExamData))
                }
            }
        } catch  {
            fatalError("获取失败")
        }
        return ret
    }
    
    static func clear() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExamData")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                for it in results {
                    managedObectContext.delete(it)
                }
            }
        } catch  {
            fatalError("获取失败")
        }
    }
}
