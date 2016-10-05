//
//  ViewController.swift
//  swiftkvokvc
//
//  Created by lotawei on 16/10/5.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit
 var   contextnumber = 0
class ViewController: UIViewController {
    @IBOutlet weak var alab: UILabel!
     let   jianshiduixiang = MyObjectToObserve()
    
    
    var    atime:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        jianshiduixiang.addObserver(self, forKeyPath: "myDate", options: .new, context: &contextnumber)
        atime  =  Timer(timeInterval: 1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
        
        RunLoop.main.add(atime!, forMode: .defaultRunLoopMode)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func update()  {
        jianshiduixiang.updatedate()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &contextnumber {
            if let  newvalue = change?[NSKeyValueChangeKey.newKey] {
                
                 let    date = newvalue  as?  NSDate
                 self.alab.text = "时间:" + self.getcurrentime(date: date!)
                
                
            }
        }
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
          atime?.invalidate()
        
         jianshiduixiang.removeObserver(self, forKeyPath: "myDate", context: &contextnumber)
    }
      func   getcurrentime(date:NSDate)->String{
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let strNowTime = timeFormatter.string(from: date as Date)
        return  strNowTime
    }

}

