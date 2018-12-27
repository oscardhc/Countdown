//
//  ViewController.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/26.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit

var exams = [Exam]()
var llable = [UILabel]()
var rlable = [UILabel]()
var charColor: UIColor!
var type = 0;

class ViewController: UIViewController {
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        exams.append(Exam(_time: "2018-12-26 14:30:00", _title: "形势与政策", _timeStr: "12月26日\n14:30"));
        exams.append(Exam(_time: "2018-12-27 14:00:00", _title: "大学英语3 小测", _timeStr: "12月27日\n14:00"));
        exams.append(Exam(_time: "2018-12-29 10:30:00", _title: "大学英语3", _timeStr: "12月29日\n10:30"));
        exams.append(Exam(_time: "2019-01-03 10:30:00", _title: "线性代数", _timeStr: "1月3日\n10:30"));
        exams.append(Exam(_time: "2019-01-04 10:30:00", _title: "思想道德修养与法律基础", _timeStr: "1月4日\n10:30"));
        exams.append(Exam(_time: "2019-01-07 13:10:00", _title: "计算机科学导论", _timeStr: "1月5日\n13:10"));
        exams.append(Exam(_time: "2019-01-10 08:00:00", _title: "数学分析(A类)(1)", _timeStr: "1月10日\n8:00"));
        exams.append(Exam(_time: "2019-01-11 13:10:00", _title: "程序设计(A类)", _timeStr: "1月11日\n13:10"));
        charColor = UIColor(red: 54/255, green: 118/255, blue: 203/255, alpha: 1.0)
        
        let frame = CGRect(x: 70, y: 100, width: 6, height: (exams.count - 1) * 60 + 150)
        let cgView = CGView(frame: frame)
        self.view.addSubview(cgView)
//        type = 1;
//        let frame2 = CGRect(x: 70, y: 70, width: 6, height: (exams.count - 1) * 60 + 20)
//        let cgView2 = CGView(frame: frame2)
//        self.view.addSubview(cgView2)
        
        print("View did load")
        print(self.view.bounds)
        
        
        for cnt in 0...exams.count - 1 {
            let lable = UILabel(frame: CGRect(x: 0, y: 100 + 60 * cnt - 2 , width: 70, height: 40))
            lable.lineBreakMode = .byCharWrapping
            lable.numberOfLines = 0
            let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]
            let str1 = NSMutableAttributedString(string: exams[cnt].timeStr + "\n\n\n", attributes: attrs1)
            lable.attributedText = str1
            lable.textAlignment = .right
            self.view.addSubview(lable)
            llable.append(lable)
        }
        for cnt in 0...exams.count - 1 {
            let lable = UILabel(frame: CGRect(x: 80, y: 100 + 60 * cnt, width: 400, height: 40))
            lable.lineBreakMode = .byCharWrapping
            lable.numberOfLines = 0
            self.view.addSubview(lable)
            rlable.append(lable)
        }
        
        
        
//        tick(lable: lable, exam: exams[0])
        
//        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.2), repeats: true, block: {
            (Timer) -> Void in
            self.tick()
        })
        
        RunLoop.main.add(timer, forMode: .common)
        
    }
    
    func tick() {
        var base = 100.0
        for cnt in 0...exams.count - 1 {
            var a = 0 - Int(Date().timeIntervalSince(exams[cnt].time))
            var sz1 = a < 0 ? 0.2 : 1.0 * exp(-Double(a) / 3600 / 24 / 15);
            var col = UIColor(red: 54/255, green: 118/255, blue: 203/255, alpha: CGFloat(sqrt(sz1)) + 0.2)
            sz1 = max(sz1, 0.5)
            if sz1 > 0.9 {
                sz1 = 0.9
            }
            let sec = a % 60
            a = a / 60
            let min = a % 60
            a = a / 60
            let hor = a % 24
            a = a / 24
            let day = a
            let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: CGFloat(sz1) * 25), NSAttributedString.Key.foregroundColor : UIColor.gray]
            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: CGFloat(sz1) * 35), NSAttributedString.Key.foregroundColor : col]
            let str1 = NSMutableAttributedString(string: exams[cnt].title + "\n", attributes: attrs1)
            let str2 = NSMutableAttributedString(string: "  \(day)天\(hor)小时\(min)分\(sec)秒\n\n\n\n", attributes: attrs2)
            str1.append(str2)
            rlable[cnt].attributedText = str1
            rlable[cnt].frame = CGRect(x: 80, y: base, width: 400, height: 80 * sz1)
            llable[cnt].frame = CGRect(x: 0, y: base , width: 70, height: 40)
            base = base + sz1 * 100
        }
    }

}

class CGView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        if (type == 0) {
            //获取绘图上下文
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            
            //创建一个矩形，它的所有边都内缩3
            let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
            
            //创建并设置路径
            let path = CGMutablePath()
            path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
            //        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
            path.addLine(to:CGPoint(x:drawingRect.minX, y:drawingRect.maxY))
            
            //添加路径到图形上下文
            context.addPath(path)
            
            //设置笔触颜色
            context.setStrokeColor(charColor.cgColor)
            //设置笔触宽度
            context.setLineWidth(1.5)
            //设置阴影
            //        context.setShadow(offset: CGSize(width:-1, height:1), blur: 0.6, color: UIColor.lightGray.cgColor)
            
            //绘制路径
            context.strokePath()
        } else {
            let center = CGPoint(x: 100, y: 100);
            
            guard let ctx = UIGraphicsGetCurrentContext() else { return }
            ctx.beginPath()
            
            //6
            ctx.setLineWidth(5)
            
            let x:CGFloat = center.x
            let y:CGFloat = center.y
            let radius: CGFloat = 10.0
            let endAngle: CGFloat = CGFloat(2 * M_PI)
            
            ctx.addArc(center: CGPoint(x: x,y: y), radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            
            ctx.strokePath()
        }
        
        
    }
    
}
