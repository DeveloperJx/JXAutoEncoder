# JXAutoEncoder
Swift 3.0 自动编解码--致敬MJ大神的MJExtension

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/DeveloperJx/JXAutoEncoder/master/LICENSE)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/JXAutoEncoder.svg)](https://img.shields.io/cocoapods/v/JXAutoEncoder.svg)


**JXAutoEncoder** 是一个通过Swift Reflect实现的，自动归解档的类，通过继承该类，可简化Swift下归档、解档的代码。功效类似于MJExtension的一句宏实现自动归解档。只是Swift不支持宏定义，又没有Runtime，一句一句写编码、解码简直写到吐血，才催生出了这个**JXAutoEncoder**


##效果

使用前

```Swift
class ArchiverModel: NSObject, NSCoding {
    
    var bool = true
    var int = 1
    var double = M_PI
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        if let boolValue = aDecoder.decodeObject(forKey: "bool") as? Bool {
            bool = boolValue
        }
        if let intValue = aDecoder.decodeObject(forKey: "int") as? Int {
            int = intValue
        }
        if let doubleValue = aDecoder.decodeObject(forKey: "double") as? Double {
            double = doubleValue
        }
        if let stringValue = aDecoder.decodeObject(forKey: "string") as? String {
            string = stringValue
        }
        if let arrayValue = aDecoder.decodeObject(forKey: "array") as? [String] {
            array = arrayValue
        }
        if let dictionaryValue = aDecoder.decodeObject(forKey: "dictionary") as? [String: String] {
            dictionary = dictionaryValue
        }
        if let dataValue = aDecoder.decodeObject(forKey: "data") as? Data {
            data = dataValue
        }
        if let dateValue = aDecoder.decodeObject(forKey: "date") as? Date {
            date = dateValue
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bool, forKey: "bool")
        aCoder.encode(int, forKey: "int")
        aCoder.encode(double, forKey: "double")
        aCoder.encode(string, forKey: "string")
        aCoder.encode(string, forKey: "array")
        aCoder.encode(string, forKey: "dictionary")
        aCoder.encode(string, forKey: "data")
        aCoder.encode(string, forKey: "date")
    }
}
```

使用后

```Swift
	
	import JXAutoEncoder

	class ArchiverModel: JXAutoEncoder {
    
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
```

## 使用方法
对需要归解档的类，直接继承JXAutoEncoder，实现系统方法archiveToFile（归档到文件）和decodedFromFile（从文件解档）即可，如下所示（PS：不要忘记import JXAutoEncoder）：

```Swift
	
	import JXAutoEncoder

	class ArchiverModel: JXAutoEncoder {
    
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
```

使用中，请根据需要，自行定义上述代码中的路径部分：

```Swift
var modelFile = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true)[0]
        modelFile += "/model.data"
```

## 安装
1. 下载ZIP包,将`Source/JXAutoEncoder.swift`资源文件拖到工程中。
2. [CocoaPods](https://cocoapods.org/)安装：
```
pod 'JXAutoEncoder' 
```

您可以使用`pod search JXAutoEncoder`查看所有版本，在`pod search`之前请先执行`pod setup`。最新版本为1.0.1。

## 其他
本库没有导入任何其他的第三方内容，可以放心使用。在使用前，您可以查看[示例程序](https://github.com/DeveloperJx/JXAutoEncoder/tree/master/Demo)

* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
* 如果你有什么建议可以Issues我，谢谢
* 工具类虽小，但如果你觉得它还是有那么一些用的，欢迎star
