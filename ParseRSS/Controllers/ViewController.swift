//
//  ViewController.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // -- UI Elements
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var viewLoad: UIView!
    @IBOutlet weak var viewLoadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelInfoURL: UILabel!
    
    // -- Variables
    var rssParser : RSSParser!
    var rssItems : [RSSItem] = []
    let rssURL = URL(string:"") // -- Your URL here
    
    // -- Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
    }
    
    // -- Custom UI Elements
    fileprivate func initCustomView() {
        
        self.viewLoadIndicator.startAnimating()
        self.newsTableView.estimatedRowHeight = 260
        self.newsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // -- Check if has image at item
    func hasImageAtIndex(item: RSSItem) -> Bool {
        if item.imgURL != ""{
            return true
        }
        return false
    }
    
    // -- Hidden Idicator
    fileprivate func hiddenIndicator() {
        self.viewLoadIndicator.stopAnimating()
        self.viewLoadIndicator.isHidden = true
    }
    
    // -- Update View
    fileprivate func updateView() {
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.hiddenIndicator()
                self.viewLoad.alpha = 0.0
            }, completion: nil)
            self.newsTableView.reloadData()
        })
    }
    
    // -- Request
    fileprivate func parse() {
        
        guard self.rssURL != nil else {
            self.hiddenIndicator()
            self.labelInfoURL.isHidden = false
            return
        }
        
        self.rssParser = RSSParser()
        self.rssParser.parseWithContentOfURL(rssURL: rssURL!) { (items) in
            for item in items{
                self.rssItems.append(item)
            }
            self.updateView()
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.rssItems[indexPath.row]
        
        if hasImageAtIndex(item: item) {
            let cellWithImg = ContentCellWithImg.customCell(rss:item, tableView: self.newsTableView, indexPath: indexPath)
            return cellWithImg
        } else{
            let cellWithoutImg = ContentCellWithoutImg.customCell(rss:item, tableView: self.newsTableView, indexPath: indexPath)
            return cellWithoutImg
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.rssItems[indexPath.row]
        let link : String = item.link
        
        if let urlEncoded = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: urlEncoded.replacingOccurrences(of: "%20", with: ""))
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
}

