//
//  MyObjectToObserve.swift
//  swiftkvokvc
//
//  Created by lotawei on 16/10/5.
//  Copyright © 2016年 lotawei. All rights reserved.
//

//在 Swift 中使用 KVO 的前提条件：1.观察者和被观察者都必须是 NSObject 的子类；2.观察的属性需要使用 @dynamic 关键字修饰。这与在 OC 中几乎没有多少门槛相比，确实麻烦了许多。
//条件1：观察者和被观察者都必须是 NSObject 的子类，因为 OC 中KVO的实现基于 KVC 和 runtime 机制，只有是 NSObject 的子类才能利用这些特性，具体的实现细节可参考官方文档：KVO Implementation Details。
//


import UIKit

class MyObjectToObserve: NSObject {
    dynamic    var    myDate =  NSDate()
    
    func updatedate()  {
          myDate = NSDate()
    }
}
var  myContext = 0
class MyObserver: NSObject {
    var objectToObserve = MyObjectToObserve()
    override init() {
        super.init()
        objectToObserve.addObserver(self, forKeyPath: "myDate", options: .new, context: &myContext)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       
        if context == &myContext {
            if let  newvalue = change?[NSKeyValueChangeKey.newKey] {
                 print("Date changed: \(newvalue)")
            }
        }
        else{
             super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
        
    }
    
    
    deinit {
        objectToObserve.removeObserver(self, forKeyPath: "myDate", context: &myContext)
    }
}
