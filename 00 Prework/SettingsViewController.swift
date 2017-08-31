//
//  SettingsViewController.swift
//  Tipsyy
//
//  Created by YingYing Zhang on 8/27/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var settingsTipControl: UISegmentedControl!
    
    //let ViewBgColors = [UIColor.white, UIColor.yellow, UIColor.orange]
    
    @IBOutlet var settingsView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Settings view will appear")
        
        let defaults = UserDefaults.standard
        
        let savedDefaultPercentage = defaults.integer(forKey: "savedSettingsTipControl");
        //let savedDefaultPercentageColor = defaults.integer(forKey: "savedSettingsTipControlColor");
        
        //print("Settings page - savedSettingsTipControl: \(savedDefaultPercentage)")
        
        //print("Settings page - savedSettingsTipControlColor: \(savedDefaultPercentageColor)")
        
        settingsTipControl.selectedSegmentIndex = savedDefaultPercentage
        //settingsView.backgroundColor = ViewBgColors[savedDefaultPercentageColor]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Settings view did appear")
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Settings view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Settings view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func setDefaultPercentage(_ sender: Any) {
        
        let defaults = UserDefaults.standard // Swift 3 syntax, previously NSUserDefaults.standardUserDefaults()
        
        defaults.set(settingsTipControl.selectedSegmentIndex, forKey: "savedSettingsTipControl")
        //defaults.set(ViewBgColors[settingsTipControl.selectedSegmentIndex], forKey: "savedSettingsTipControlColor")
        
        defaults.synchronize()
    
    }
    /*
    @IBAction func changeViewColor(_ sender: Any) {
        switch settingsTipControl.selectedSegmentIndex {
        case 0: settingsView.backgroundColor = UIColor.white
         // case 0: settingsView.backgroundColor = ViewBgColors[0]
        //case 1: tipCalculatorView.backgroundColor = UIColor(red:1, green:1, blue: 233, alpha:1)
        case 1: settingsView.backgroundColor = UIColor(red:1, green:255, blue: 102/255, alpha:1)
        case 2: settingsView.backgroundColor =  UIColor(red:1, green:204/255, blue: 102/255, alpha:1)
        default: print ("hello no colors set for the background")
        }
    
    }
 */
}
