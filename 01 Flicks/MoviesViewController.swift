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

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var networkErrorView: UIView!
    
    var endpoint: String = "now_playing"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [NSDictionary]? // data
    
    var filteredData: [NSDictionary]?
    
    var genreDictionary: [NSData]?
    var genres: [NSDictionary]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGenresFromUrl() // get Genre json
        
        // search bar delegate
        searchBar.delegate = self
        
        // Set networkErrorView hidden by default
        self.networkErrorView.isHidden = true
        
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor(red:0.40, green:0.06, blue:0.15, alpha:1.0)
        
        // collectionView
        collectionView.dataSource = self
        //collectionView.delegate = self
        
        /*
        // collectionView flow layout
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10)
        */
        
        // network request
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // get movies
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let responseDictionary = try! JSONSerialization.jsonObject (with: data, options: []) as? NSDictionary {
                    
                    //print("response:  \(responseDictionary)")
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    self.filteredData = self.movies // for search purposes
                    
                    self.tableView.reloadData()
                    
                    // hide network error view if there's data
                    self.networkErrorView.isHidden = true
                    
                    // Hide HUD once the network request comes back (must be done on main UI thread)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            else {
                // hide network error view if there's no data
                self.networkErrorView.isHidden = false
                
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
        task.resume()
        // get movies - end
        
        // refresh control
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        // refresh control - end
        
        // Do any additional setup after loading the view.
    }
  
    // tableView protocol
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if movies != nil {
            return filteredData!.count //return filteredData!.count
        }
        else {
            return 0
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        //???cell.textLabel?.text = filteredData[indexPath.row].
        
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as! String
        let userRating = String(describing: movie["vote_average"]!)
        //let genreIdArray = movie["genre_ids"] as! NSArray
        
        //display misc info
        cell.titleLabel.text = title
        cell.userRatingLabel.text = userRating + "/10"
        
        /* trying to display genres
        //print(genres!)
         
        let genresDictArray = genres as! [[String : AnyObject]]
        //print(genresDictArray)
        
        let genreIdInArray = genresDictArray[0]["id"]! as! String
        let genreNameInArray = genresDictArray[0]["name"]! as! String
        //print("genresDictArray[0]\(genresDictArray[0]["id"]!)")
        
        for (item) in genresDictArray {
            let genresDictArrayNoKey = [genreIdInArray, genreNameInArray] as! [[String : AnyObject]]
        }
        
        print(genresDictArrayNoKey)
        */
        
        
        /*
        var genreNameArray: [String] = []
        
        for (item) in genreIdArray
        {
            //let genreName: String? = item.objectForKey("id")?.objectForKey("name") as? String
            
            let genreName: String = genres.map(item)
            //object(value(forKey: item))
            
            genreNameArray.append(", ")
            genreNameArray.append(String(genreName))
        }
 
    
        print("Genre name array: \(genreNameArray)")
        //cell.genreLabel.text = String(describing: genreIdArray)
 
        */
    
        
        // display image
        if let posterPath = movie["poster_path"] as? String {
            let baseUrl = "https://image.tmdb.org/t/p/w342"
            let imageUrl = baseUrl + posterPath
            
            let imageRequest = NSURLRequest(url: NSURL(string: imageUrl)! as URL)
            
            cell.posterView.setImageWith(
                imageRequest as URLRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        //print("Image was NOT cached, fade in image")
                        cell.posterView.alpha = 0.0
                        cell.posterView.image = image
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            cell.posterView.alpha = 1.0
                        })
                    } else {
                        //print("Image was cached so just update the image")
                        cell.posterView.image = image
                    }
            },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
        
        //print("filtereddata from tableview: \(filteredData![indexPath.row]["title"]!)")
        //cell = filteredData![indexPath.row]
        
        return cell
    }
    
    // tableView protocol - end
    
    // collectionView protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if movies != nil {
            return filteredData!.count //return filteredData!.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionMovieCell", for: indexPath) as! CollectionMovieCell
        
        let movie = movies![indexPath.row]
        
        // display image
        if let posterPath = movie["poster_path"] as? String {
            let baseUrl = "https://image.tmdb.org/t/p/w342"
            let imageUrl = baseUrl + posterPath
            
            let imageRequest = NSURLRequest(url: NSURL(string: imageUrl)! as URL)
            
            cell.collectionPosterImageView.setImageWith(
                imageRequest as URLRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        //print("Image was NOT cached, fade in image")
                        cell.collectionPosterImageView.alpha = 0.0
                        cell.collectionPosterImageView.image = image
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            cell.collectionPosterImageView.alpha = 1.0
                        })
                    } else {
                        //print("Image was cached so just update the image")
                        cell.collectionPosterImageView.image = image
                    }
            },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
        
        print("filtereddata from tableview: \(filteredData![indexPath.row]["title"]!)")
        //cell = filteredData![indexPath.row]
        
        return cell
    }
    // collectionView protocol - end

    
    //search bar functionality related
    // This method updates filteredData based on the text in the Search Box
    // When there is no text, filteredData is the same as the original data
    // When user has entered text into the search box
    // Use the filter method to iterate over all items in the data array
    // For each item, return true if the item should be included and false if the
    // item should NOT be included
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredData = searchText.isEmpty ? self.movies : self.movies!.filter { (item: NSDictionary) -> Bool in
            // If dataItem matches the searchText, return true to include it
                //print("searchText: \(searchText)")
                let title = item["title"] as! String
                //print("title match: \(title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil))")
                return title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        }
        
        tableView.reloadData()
    }
 
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    //search bar functionality related - end
 
    
    // refresh control
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        //let genreUrl = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US")
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //let genreRequest = URLRequest(url: genreUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // get movies
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
        // get movies - end
    }
    // refresh control - end
    
    // get genre json
    func getGenresFromUrl(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        //creating a NSURL
        let genreUrl = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US")
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (genreUrl)!, completionHandler: {(data, response, error) -> Void in
            
            if let genreDictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                self.genres = genreDictionary?["genres"] as? [NSDictionary]
                
                //print(self.genres)
            }
        }).resume()
        
    }
    // get genre json - end
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        //let genre = genres ?? how to write which genre
        let detailsViewController = segue.destination as! DetailsViewController
        
        detailsViewController.movie = movie
        
        cell.selectionStyle = .none
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // Others
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
