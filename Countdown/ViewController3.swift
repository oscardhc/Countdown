//
//  ViewController3.swift
//  Countdown
//
//  Created by Haichen Dong on 2018/12/27.
//  Copyright © 2018 Haichen Dong. All rights reserved.
//

import UIKit
import WebKit

class ViewController3: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: self.view.bounds)
//        webView.loadFileURL(URL(string: Bundle.main.path(forResource: "advice", ofType: "docx")!)!, allowingReadAccessTo: URL(string: Bundle.main.path(forResource: "advice", ofType: "docx")!)!)
        let request = URLRequest(url: Bundle.main.url(forResource: "advice", withExtension: "docx")!)
        webView.load(request)
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
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
