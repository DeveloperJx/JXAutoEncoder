//
//  JXAutoEncoder.swift
//  JXAutoEncoder
//
//  Created by gxcb on 2017/2/9.
//  Copyright © 2017年 jx. All rights reserved.
//

import UIKit

class JXAutoEncoder: NSObject, NSCoding {
    
    // MARK:- 处理需要归档的字段
    
    func encode(with aCoder:NSCoder) {
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            aCoder.encode(value, forKey: label)
        }
    }
    
    // MARK:- 处理需要解档的字段
    
    required init(coder aDecoder:NSCoder) {
        super.init()
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, _) in mirror.children {
            guard aDecoder.decodeObject(forKey: label) != nil else {
                return
            }
            setValue(aDecoder.decodeObject(forKey: label), forKey: label)
        }
    }
    
    override init() {
        super.init()
    }
}
