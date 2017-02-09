//
//  ViewController.swift
//  JXAutoEncoder
//
//  Created by gxcb on 2017/2/9.
//  Copyright © 2017年 jx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonArchive(_ sender: Any) {
        ArchiverModel().archiveToFile()
    }

    @IBAction func buttonDecode(_ sender: Any) {
        let model = ArchiverModel.decodedFromFile()
        print(model.description)
    }
    
    @IBAction func buttonRemove(_ sender: Any) {
        ArchiverModel.removeFile()
    }
}

