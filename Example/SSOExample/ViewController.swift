//
//  ViewController.swift
//  SSOExample
//
//  Created by 82123683 on 10/14/2022.
//  Copyright (c) 2022 82123683. All rights reserved.
//

import UIKit
import SSOExample

class ViewController: UIViewController {
    var auth2 = AuthSSO()
    override func viewDidLoad() {
        super.viewDidLoad()
        auth2.signIn(completion: <#T##(String, Error?) -> ()#>)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

