//
//  TBController.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/27.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit

class TBController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let view1 = ViewController()
        view1.title = "Exams"
        view1.tabBarItem.image = UIImage(named: "4")
        let view2 = ViewController2()
        view2.title = "教务系统"
        
        //分别声明两个视图控制器
        let con1 = UINavigationController(rootViewController: view1)
//        con1.tabBarItem.image = UIImage(named:"1")
        //定义tab按钮添加个badge小红点值
        con1.tabBarItem.badgeValue = "!"
        
        let con2 = UINavigationController(rootViewController: view2)
        con2.tabBarItem.image = UIImage(named:"5")
        
        self.viewControllers = [con1, con2]
        
        //默认选中的是游戏主界面视图
        self.selectedIndex = 0
        
        up = Double(con1.navigationBar.bounds.height)
        down = Double(self.tabBar.bounds.height)
        if self.view.bounds.height == 812 {
            down = 49 + 34
        }
    
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
