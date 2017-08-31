//
//  ViewController.swift
//  Tipsyy
//
//  Created by YingYing Zhang on 8/27/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tipCalculatorView: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    /* split labels */
    @IBOutlet weak var splitOneLabel: UILabel!
    
    @IBOutlet weak var splitTwoLabel: UILabel!
    
    @IBOutlet weak var splitThreeLabel: UILabel!
    
    @IBOutlet weak var splitFourLabel: UILabel!
    
    @IBOutlet weak var splitFiveLabel: UILabel!
    
    @IBOutlet weak var splitSixLabel: UILabel!
    /* split labels end */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //billField.becomeFirstResponder;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.becomeFirstResponder();
        
        print("view will appear")
        
        let defaults = UserDefaults.standard
        
        let setTipControlToSetting = defaults.integer(forKey: "savedSettingsTipControl")
        
        let bill = defaults.string(forKey: "savedBillField")
        
        
        
        //let stringValue = defaults.objectForKey("some_key_that_you_choose") as! String
        //let intValue = defaults.integerForKey("another_key_that_you_choose")
        
        tipControl.selectedSegmentIndex = setTipControlToSetting
        
        billField.text = bill
        
        calTips(self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        self.tipCalculatorView.alpha = 0
        //self.view.alpha = 1
        UIView.animate(withDuration: 0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.tipCalculatorView.alpha = 1
            //self.view.alpha = 0
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    
    }
    
    
    @IBAction func calTips(_ sender: Any) {
        
        let tipPercentage = [0.10, 0.15, 0.20]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let splitOne = total
        let splitTwo = total/2
        let splitThree = total/3
        let splitFour = total/4
        let splitFive = total/5
        let splitSix = total/6
        
        //tipLabel.text = String(tip);
        //totalLabel.text = String(total);
        
        //tipLabel.text = "$\(tip)";
        //totalLabel.text = "$\(total)";
        
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
        splitOneLabel.text = String(format: "$%.2f", splitOne);
        splitTwoLabel.text = String(format: "$%.2f", splitTwo);
        splitThreeLabel.text = String(format: "$%.2f", splitThree);
        splitFourLabel.text = String(format: "$%.2f", splitFour);
        splitFiveLabel.text = String(format: "$%.2f", splitFive);
        splitSixLabel.text = String(format: "$%.2f", splitSix);
    
        let defaults = UserDefaults.standard // Swift 3 syntax, previously NSUserDefaults.standardUserDefaults()
        
        defaults.set(billField.text, forKey: "savedBillField")
        //defaults.set(ViewBgColors[settingsTipControl.selectedSegmentIndex], forKey: "savedSettingsTipControlColor")
        
        defaults.synchronize()
    
    }
    
    
    @IBAction func onSplitOneShareTapped(_ sender: Any) {
        let splitOneAcitivityController = UIActivityViewController (activityItems: ["Remember to pay me:\(splitOneLabel.text)"], applicationActivities: nil )
        present(splitOneAcitivityController, animated: true, completion: nil)
    }
   
}

