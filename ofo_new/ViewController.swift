//
//  ViewController.swift
//  ofo_new
//
//  Created by idea on 2017/7/24.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import SWRevealViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        SWRevealViewController
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "ofoLogo"))
        
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "leftTopImage").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "rightTopImage").withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if let revealVC = revealViewController(){
            
//             宽度
            revealVC.rearViewRevealWidth = 280
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

