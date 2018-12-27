//
//  Exam.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/27.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit

class Exam: NSObject {
    var time : Date
    var title : String
    var timeStr : String
    
    init(_time : String, _title : String, _timeStr: String) {
        let fmt = DateFormatter();
        let zone = TimeZone(identifier: "Asia/Shanghai")
        fmt.timeZone = zone!
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        time = fmt.date(from: _time)!
        title = _title
        timeStr = _timeStr
    }
}
