//
//  ArchiverModel.swift
//  JXAutoEncoder
//
//  Created by gxcb on 2017/2/9.
//  Copyright © 2017年 jx. All rights reserved.
//

import UIKit

class ArchiverModel: JXAutoEncoder {
    
    var bool = true
    var int = 1
    var double = 3.14159
    var string = ""
    var array = ["123", "456"]
    var dictionary = ["abc": "cba"]
    var data = Data(base64Encoded: "hello world")
    var date = Date()
    
    
    /// 归档到文件
    func archiveToFile() {
        var modelFile = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true)[0]
        modelFile += "/model.data"
        NSKeyedArchiver.archiveRootObject(self, toFile: modelFile)
    }
    
    /// 从文件中解档
    ///
    /// - Returns: 接档后的Model
    class func decodedFromFile() -> ArchiverModel {
        var modelFile = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true)[0]
        modelFile += "/model.data"
        
        if FileManager.default.fileExists(atPath: modelFile) {
            if let model = NSKeyedUnarchiver.unarchiveObject(withFile: modelFile) as? ArchiverModel {
                return model
            }
        }
        return ArchiverModel()
    }
    
    /// 删除归档文件
    class func removeFile() {
        var modelFile = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true)[0]
        modelFile += "/model.data"
        
        if FileManager.default.fileExists(atPath: modelFile) {
            do {
                try FileManager.default.removeItem(at: URL(fileURLWithPath: modelFile))
            } catch {
                print(error)
            }
        }
    }
}
