//
//  ViewController.swift
//  ExWaterMarker
//
//  Created by muhlenXi on 2018/8/22.
//  Copyright © 2018年 muhlenXi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        
        let car = UIImage(named: "car")
        self.imageView2.image = car?.makeTiledMarkedWithWaterMarkedImageType(type: .bbs)
        
        self.imageView0.image = car
        self.imageView1.image = car?.makeWaterMarkedImage(waterMarkImage: UIImage(named: "bbsMarked")!, mode: .topLeft)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

