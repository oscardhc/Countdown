//
//  ViewController.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/26.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit
import CoreData

var exams = [Exam]()
var llable = [UILabel]()
var rlable = [UILabel]()
var charColor: UIColor!
var type = 0
var cgView = CGView()
var cirView = [UIImageView]()
var imgView = UIImageView()
var scrView = UIScrollView()
var hjView = UIImageView()
var up: Double!
var down: Double!

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var timer: Timer!
    var xx: Double!
    var yy: Double!
    var linex: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(up, down)
        clearView()
        
        scrView = UIScrollView(frame: CGRect(x: 0.0, y: up, width: Double(self.view.bounds.maxX), height: Double(self.view.bounds.maxY) - down - 150 - up))
        // 设置是否翻页
        scrView.isPagingEnabled = false
        // 可以滚动的区域
        scrView.contentSize = CGSize(width: self.view.bounds.maxX, height: self.view.bounds.maxY)
        // 显⽰示⽔水平滚动条
        scrView.showsHorizontalScrollIndicator = true
        // 显⽰示垂直滚动条
        scrView.showsVerticalScrollIndicator = true
        // 滚动条样式
        scrView.indicatorStyle = .default
        // 设置回弹效果
        scrView.bounces = true
        // 设置scrollView可以滚动
        scrView.isScrollEnabled = true
        // 当scrollsToTop=true时，点击设备状态栏会自动滚动到顶部
        scrView.scrollsToTop = true
        // 缩放的最小比例
        scrView.minimumZoomScale = 0.5
        // 放大的最大比例
        scrView.maximumZoomScale = 2.0
        // 缩放回弹
        scrView.bouncesZoom = true
        scrView.delegate = self
        
        self.view.addSubview(scrView)
        
        xx = Double(scrView.bounds.maxX)
        yy = Double(scrView.bounds.maxY)
        linex = xx * 0.23
        
        exams = DataManager.getData()
        exams.sort { (a, b) -> Bool in
            return Int(Date().timeIntervalSince(a.time)) > Int(Date().timeIntervalSince(b.time))
        }
        
        charColor = UIColor(red: 54/255, green: 118/255, blue: 203/255, alpha: 1.0)
        
        let addbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        addbtn.setTitle("add", for: .normal)
        addbtn.setTitleColor(charColor, for: .normal)
        addbtn.addTarget(for: .touchUpInside) { (btn) in
            self.clicked()
        }
        let itm1 = UIBarButtonItem(customView: addbtn)
        let addbtn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        addbtn2.setTitle("reset", for: .normal)
        addbtn2.setTitleColor(charColor, for: .normal)
        addbtn2.addTarget(for: .touchUpInside) { (btn) in
            self.reset()
        }
        let itm2 = UIBarButtonItem(customView: addbtn2)
        self.navigationItem.rightBarButtonItem = itm1
        self.navigationItem.leftBarButtonItem = itm2
        
        addView()
        print("View did load")
        print(self.view.bounds)
        
        hjView = UIImageView(image: UIImage(named: "6"))
        scrView.addSubview(hjView)
        
        tick();
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.2), repeats: true, block: {
            (Timer) -> Void in
            self.tick()
        })
        
        RunLoop.main.add(timer, forMode: .common)
        
    }
    func addView() {
        print("ADD VIEW \(exams.count)")
        if exams.count == 0 {
            return;
        }
        for cnt in 0...exams.count - 1 {
            let lable = UILabel(frame: CGRect(x: 0.0, y: Double(10 + 60 * cnt - 2) , width: linex - 5.0, height: 40.0))
            lable.lineBreakMode = .byCharWrapping
            lable.numberOfLines = 0
            let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]
            let str1 = NSMutableAttributedString(string: exams[cnt].timeStr + "\n\n\n", attributes: attrs1)
            lable.attributedText = str1
            lable.textAlignment = .right
            scrView.addSubview(lable)
            llable.append(lable)
            print(cnt)
        }
        for cnt in 0...exams.count - 1 {
            let lable = UILabel(frame: CGRect(x: linex + 5.0, y: Double(10 + 60 * cnt), width: 400, height: 40))
            lable.lineBreakMode = .byCharWrapping
            lable.numberOfLines = 0
            scrView.addSubview(lable)
            rlable.append(lable)
        }
        for cnt in 0...exams.count - 1 {
            cirView.append(UIImageView(image: UIImage(named: "1.png")))
            cirView[cnt].frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            scrView.addSubview(cirView[cnt])
        }
        imgView = UIImageView(image: UIImage(named: "2.jpg"))
        imgView.frame = CGRect(x: Double(xx / 2 - 75) , y: Double(self.view.bounds.maxY) - 150 - down, width: 150.0, height: 150.0)
        self.view.addSubview(imgView)
    }
    func clearView() {
        if exams.count == 0 {
            return
        }
        for cnt in 0...exams.count - 1 {
            llable[cnt].removeFromSuperview()
            rlable[cnt].removeFromSuperview()
            cirView[cnt].removeFromSuperview()
        }
        imgView.removeFromSuperview()
        cirView = [UIImageView]()
        imgView = UIImageView()
        llable = [UILabel]()
        rlable = [UILabel]()
    }
    func reset() {
        clearView()
        DataManager.clear()
        exams = [Exam]()
        
        exams.append(Exam(_time: "2018-12-26 14:30:00", _title: "形势与政策", _timeStr: "12月26日\n14:30"));
//        exams.append(Exam(_time: "2018-12-27 14:00:00", _title: "大学英语3 小测", _timeStr: "12月27日\n14:00"));
        exams.append(Exam(_time: "2018-12-29 10:30:00", _title: "大学英语", _timeStr: "12月29日\n10:30"));
        exams.append(Exam(_time: "2019-01-03 10:30:00", _title: "线性代数", _timeStr: "1月3日\n10:30"));
        exams.append(Exam(_time: "2019-01-04 10:30:00", _title: "思想道德修养与法律基础", _timeStr: "1月4日\n10:30"));
        exams.append(Exam(_time: "2019-01-07 13:10:00", _title: "计算机科学导论", _timeStr: "1月7日\n13:10"));
        exams.append(Exam(_time: "2019-01-10 08:00:00", _title: "数学分析(A类)(1)", _timeStr: "1月10日\n8:00"));
        exams.append(Exam(_time: "2019-01-11 13:10:00", _title: "程序设计(A类)", _timeStr: "1月11日\n13:10"));
        
        for exm in exams {
            exm.save()
        }
        
        print("!!\(exams.count)")
        addView()
    }
    func clicked() {
        let alertController = UIAlertController(title: "添加事件",
                                                message: "请输入信息", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "事件名称"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "年(yyyy)"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "月(MM)"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "日(dd)"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "时(hh)"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "分(mm)"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
//            let login = alertController.textFields!.first!
//            let password = alertController.textFields!.last!
            let time = "\(alertController.textFields![1].text!)-\(alertController.textFields![2].text!)-\(alertController.textFields![3].text!) \(alertController.textFields![4].text!):\(alertController.textFields![5].text!):00"
            let timeStr = "\(alertController.textFields![2].text!)月\(alertController.textFields![3].text!)日\n\(alertController.textFields![4].text!):\(alertController.textFields![5].text!)"
            let cur = Exam(_time: time, _title: alertController.textFields![0].text!, _timeStr: timeStr)
            cur.save()
            self.clearView()
            exams.append(cur)
            exams.sort { (a, b) -> Bool in
                return Int(Date().timeIntervalSince(a.time)) > Int(Date().timeIntervalSince(b.time))
            }
            self.addView()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func tick() {
        if exams.count == 0 {
            return
        }
        var base = 10.0
        var flg = -1000000000
        var lst = 0.0
        for cnt in 0...exams.count - 1 {
            var a = 0 - Int(Date().timeIntervalSince(exams[cnt].time))
            let aa = a
            var sz1 = a < 0 ? 0.2 : 1.0 * exp(-Double(a) / 3600 / 24 / 20);
            let col = UIColor(red: 54/255, green: 118/255, blue: 203/255, alpha: CGFloat(sqrt(sz1)) + 0.2)
            sz1 = max(sz1, 0.55)
            a = abs(a)
            let sec = a % 60
            a = a / 60
            let min = a % 60
            a = a / 60
            let hor = a % 24
            a = a / 24
            let day = a
            if flg < 0 && aa > 0 {
                hjView.frame = CGRect(x: linex - 7.5, y: base - lst + (50.0 + lst) * Double(-flg) / Double(aa - flg) - 7.5 + 13 - 2.5, width: 15, height: 15)
//                print(flg, aa, base, base - lst, base + 50, Double(-flg) / Double(aa - flg), base - lst + (50.0 + lst) * Double(-flg) / Double(aa - flg) - 7.5)
                base = base + 50
            }
            flg = aa
            let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: CGFloat(sz1) * 23), NSAttributedString.Key.foregroundColor : UIColor.gray]
            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: CGFloat(sz1) * 30), NSAttributedString.Key.foregroundColor : col]
            let str1 = NSMutableAttributedString(string: exams[cnt].title + "\n", attributes: attrs1)
            let str2 = NSMutableAttributedString(string: "  \(day)天\(hor)小时\(min)分\(sec)秒" + (aa < 0 ? "前" : "") + "\n\n\n\n", attributes: attrs2)
            str1.append(str2)
            rlable[cnt].attributedText = str1
//            print(base)
            rlable[cnt].frame = CGRect(x: linex + 5.0, y: base, width: 400, height: 80 * sz1)
            llable[cnt].frame = CGRect(x: 0, y: base , width: linex - 5.0, height: 40)
            cirView[cnt].frame = CGRect(x: linex - 2.5, y: base + 13, width: 5, height: 5)
            if (cnt != exams.count - 1) {
                base = base + sz1 * 100
                lst = sz1 * 100
            }
        }
        type = 0
        cgView.removeFromSuperview()
        let frame = CGRect(x: linex - 3, y: 20, width: 6, height: base)
        cgView = CGView(frame: frame)
        scrView.addSubview(cgView)
        
        scrView.bringSubviewToFront(hjView)
        
        scrView.contentSize = CGSize(width: self.view.bounds.maxX, height: CGFloat(base + 100))
//        print(base + 100)
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
            super.draw(rect)
            print(rect)
            //获取绘图上下文
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            
            //创建一个矩形，它的所有边都内缩3
            let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
            
            //创建并设置路径
            let path = CGMutablePath()
            
            //圆弧半径
            let radius = min(drawingRect.width, drawingRect.height)/2
            //圆弧中点
            let center = CGPoint(x:drawingRect.midX, y:drawingRect.midY)
            //绘制圆弧
            path.addArc(center: center, radius: radius, startAngle: 0,
                        endAngle: CGFloat.pi * 2.0, clockwise: false)
            
            //添加路径到图形上下文
            context.addPath(path)
            
            //设置笔触颜色
            context.setStrokeColor(UIColor.orange.cgColor)
            //设置笔触宽度
            context.setLineWidth(6)
            
            //绘制路径
            context.strokePath()
        }
        
        
    }
    
}
