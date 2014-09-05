//
//  ViewController.swift
//  Battery
//
//  Created by artwalk on 9/5/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let device = UIDevice.currentDevice()
    
    var timer:NSTimer?
    var curBatteryLevel = 6
    
    @IBOutlet weak var batteryStateLabel: UILabel!
    @IBOutlet weak var batteryImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        device.batteryMonitoringEnabled = true
        
        switch device.batteryState {
        case UIDeviceBatteryState.Charging:
            batteryImageView.image = UIImage(named: "Energy-2")
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateBatteryImageViewWithCharging", userInfo: nil, repeats: true)

            println("Charging")
            
        case UIDeviceBatteryState.Full:
            batteryImageView.image = UIImage(named: "Energy8")
            
            println("Full")
        case UIDeviceBatteryState.Unplugged:
            println("Unplugged")
            
        case UIDeviceBatteryState.Unknown:
            batteryImageView.image = UIImage(named: "Energy-1")
            println("Unknown")
        }
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        device.batteryMonitoringEnabled = false
        
        super.viewWillDisappear(animated)
    }

    func updateBatteryImageViewWithCharging() {
        self.batteryStateLabel.text = "BatteryLevel : \(device.batteryLevel * 100)%"
        var sysBatteryLevel =  Int(device.batteryLevel*8.0)
        
        self.curBatteryLevel = (++self.curBatteryLevel%9 < sysBatteryLevel) ? sysBatteryLevel : self.curBatteryLevel
//        println("\(sysBatteryLevel) --- \(self.curBatteryLevel) ")
        batteryImageView.image = UIImage(named: "Energy\(self.curBatteryLevel)")
    }

    
}

