//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by YingYing Zhang on 9/13/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    var imageURL: URL!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.setImageWith(imageURL)
        // Do any additional setup after loading the view.
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

}
