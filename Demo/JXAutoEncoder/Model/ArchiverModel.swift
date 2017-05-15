//
//  ArchiverModel.swift
//  JXAutoEncoder
//
//  Created by jx on 2017/2/9.
//  Copyright © 2017年 jx. All rights reserved.
//

import UIKit

class ArchiverModel: JXAutoEncoder {
    
    var bool = true
    var int = 1
    var double = CGFloat.pi
    var string = ""
    var array = ["123", "456"]
    var dictionary = ["abc": "cba"]
    var data = "hello world".data(using: String.Encoding.utf8)
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
    /// - Returns: 解档后的Model
    class func decodedFromFile() throws -> ArchiverModel {
        var modelFile = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true)[0]
        modelFile += "/model.data"
        
        if FileManager.default.fileExists(atPath: modelFile) {
            if let model = NSKeyedUnarchiver.unarchiveObject(withFile: modelFile) as? ArchiverModel {
                return model
            }else{
                throw NSError(domain: "Unarchive fail", code: 100, userInfo: nil)
            }
        }else{
            throw NSError(domain: "File doesn't exists", code: 101, userInfo: nil)
        }
    }
    
    /// 删除归档文件
    class func removeFile() throws {
        var modelFile = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true)[0]
        modelFile += "/model.data"
        
        if FileManager.default.fileExists(atPath: modelFile) {
            do {
                try FileManager.default.removeItem(at: URL(fileURLWithPath: modelFile))
            } catch {
                throw NSError(domain: "Remove file fail", code: 101, userInfo: nil)
            }
        }else{
            throw NSError(domain: "File doesn't exists", code: 101, userInfo: nil)
        }
    }
}
