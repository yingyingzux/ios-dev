//
//  MoviesViewController.swift
//  01 Flicks
//
//  Created by YingYing Zhang on 9/14/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var networkErrorView: UIView!
    
    var endpoint: String = "now_playing"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [NSDictionary]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // network request
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Set networkErrorView hidden by default
        self.networkErrorView.isHidden = true
        
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let responseDictionary = try! JSONSerialization.jsonObject (with: data, options: []) as? NSDictionary {
                    
                    //print("response:  \(responseDictionary)")
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    
                    self.tableView.reloadData()
                    
                    // Hide HUD once the network request comes back (must be done on main UI thread)
                    self.networkErrorView.isHidden = true
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                }
            }
            else {
                self.networkErrorView.isHidden = false
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
        
        task.resume()
        
        // refresh control
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
 
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let movies = movies {
            return movies.count
        }
        else {
            return 0
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        if let posterPath = movie["poster_path"] as? String {
            let baseUrl = "https://image.tmdb.org/t/p/w342"
        
            let imageUrl = NSURL (string: baseUrl + posterPath)
            
            //cell.posterView.setImageWith(imageUrl! as URL)
            
            //let imageRequest = NSURLRequest(URL: NSURL(string: imageUrl)!)
            let imageRequest = NSURLRequest(url: imageUrl)
            
            cell.posterImageView.setImageWithURLRequest(
                imageRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        self.myImageView.alpha = 0.0
                        self.myImageView.image = image
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.myImageView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        self.myImageView.image = image
                    }
            },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
        
        //print ("row \(indexPath.row)")
        return cell
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        
        let indexPath = tableView.indexPath(for: cell)
        
        let movie = movies![indexPath!.row]
        
        let detailsViewController = segue.destination as! DetailsViewController
        
        detailsViewController.movie = movie
        
        cell.selectionStyle = .none
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let responseDictionary = try! JSONSerialization.jsonObject (with: data, options: []) as? NSDictionary {
                    
                    //print("response:  \(responseDictionary)")
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    
                    self.tableView.reloadData()
                    
                    refreshControl.endRefreshing()
                }
            }
        }
        
        task.resume()
        
    }
    
}
