//
//  ViewController2.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/27.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn = UIButton(frame: CGRect(x: self.view.bounds.maxX / 2 - 100, y: self.view.bounds.maxY / 2 - 30, width: 200, height: 40))
        btn.setTitle("期末考试复习建议", for: .normal)
        btn.setTitleColor(charColor, for: .normal)
        btn.addTarget(for: .touchUpInside, action: {
            (UIButton) -> Void in
            self.tap()
        })
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
        
    }
    
    func tap() {
//        let alertControler = UIAlertController(title: "操作成功", message: "恭喜！你已经成功退学！", preferredStyle: .alert)
//        let okAction=UIAlertAction(title: "Yes", style: .default, handler: nil)
//        alertControler.addAction(okAction)
//        self.present(alertControler, animated: true, completion: nil)
        self.navigationController?.pushViewController(ViewController3(), animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIButton{
    
    struct AssociatedClosureClass {
        var eventClosure: (UIButton)->()
    }
    
    private struct AssociatedKeys {
        static var eventClosureObj:AssociatedClosureClass?
    }
    
    private var eventClosureObj: AssociatedClosureClass{
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.eventClosureObj, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        get{
            return (objc_getAssociatedObject(self, &AssociatedKeys.eventClosureObj) as? AssociatedClosureClass)!
        }
    }
    
    func addTarget(for controlEvents: UIControl.Event,action:@escaping (UIButton)->()) {
        let eventObj = AssociatedClosureClass(eventClosure: action)
        eventClosureObj = eventObj
        addTarget(self, action: #selector(eventExcuate(_:)), for: controlEvents)
        
    }
    
    @objc private func eventExcuate(_ sender: UIButton){
        eventClosureObj.eventClosure(sender)
    }
}

