//
//  ViewController.swift
//  JXAutoEncoder
//
//  Created by jx on 2017/2/9.
//  Copyright © 2017年 jx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 需要被归档和解档的Model
    var model = ArchiverModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 归档到文件
    @IBAction func buttonArchive(_ sender: Any) {
        showArchiverModelDetail(stateString: "归档到文件的Model")
        model.archiveToFile()
    }
    
    /// 从文件解档
    @IBAction func buttonUnarchive(_ sender: Any) {
        showArchiverModelDetail(stateString: "从文件解档的Model")
        do {
            try model = ArchiverModel.decodedFromFile()
        } catch {
            let alert = UIAlertController(title: "失败(Fail)", message: "解档失败(Unarchiver fail)", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "确定(OK)", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            present(alert, animated: true, completion: nil)
        }
    }
    
    /// 删除归档文件
    @IBAction func buttonRemove(_ sender: Any) {
        do {
            try ArchiverModel.removeFile()
        } catch {
            let alert = UIAlertController(title: "失败(Fail)", message: "删除归档文件失败(Remove file fail)", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "确定(OK)", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController {
    
    func showArchiverModelDetail(stateString: String) {
        print("=========\(stateString)=========")
        print("Bool变量       : \(model.bool)")
        print("Int变量        : \(model.int)")
        print("Double变量     : \(model.double)")
        print("String变量     : \(model.string)")
        print("Array变量      : \(model.array)")
        print("Dictionary变量 : \(model.dictionary)")
        if let data = model.data {
            print("Data变量       : \(String(data: data, encoding: String.Encoding.utf8))")
        }else{
            print("Data变量       : 为空")
        }
        print("Date变量       : \(model.date)")
        print("==============================\n\n")
    }
}
