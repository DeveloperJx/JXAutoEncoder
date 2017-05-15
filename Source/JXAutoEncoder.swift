//
//  JXAutoEncoder.swift
//  JXAutoEncoder
//
//  Created by jx on 2017/2/9.
//  Copyright © 2017年 jx. All rights reserved.
//

import Foundation

public class JXAutoEncoder: NSObject, NSCoding {
    
    // MARK:- 处理需要归档的字段
    
    public func encode(with aCoder:NSCoder) {
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            aCoder.encode(value, forKey: label)
        }
    }
    
    // MARK:- 处理需要解档的字段
    
    required public init(coder aDecoder:NSCoder) {
        super.init()
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, _) in mirror.children {
            guard aDecoder.decodeObject(forKey: label) != nil else {
                return
            }
            setValue(aDecoder.decodeObject(forKey: label), forKey: label)
        }
    }
    
    override public init() {
        super.init()
    }
}
