//
//  ViewController.swift
//  Vidz
//
//  Created by Matt Houston on 6/27/16.
//  Copyright © 2016 Matthew Houston. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?

    func fetchVideos() {
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") //url with json data
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                //loop through entire json object
                for dictionary in json as! [[String:AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String:AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                //the moment i loop through all of the video objects, be sure to reload that data
                self.collectionView?.reloadData()
                
            } catch let jsonError {
                print(jsonError)
            }
            
        })  .resume() //kicks off the request
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        collectionView?.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = "Home"
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()

        return mb
    }()
    
    fileprivate func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]|", views: menuBar)
        
    }
    
    fileprivate func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: Selector("handleSearch"))
        let moreButton = UIBarButtonItem(image: UIImage(named:"nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: Selector("handleMore"))
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
        
}
    
    fileprivate func handleSearch() {
        
    }
    
    fileprivate func handleMore() {
        
    }
    
    //MARK: Collection View Delegates
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = videos?.count {
            return count
        }
        
        return videos?.count ?? 0 //returns the count if its not nil, otherwise it returns 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    //eliminate extra space you see between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}







