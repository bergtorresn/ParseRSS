//
//  ViewController.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK - UI Elements
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var viewLoad: UIView!
    @IBOutlet weak var viewLoadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelInfoURL: UILabel!
    
    // MARK -  Variables
    
    var rssParser : RSSParser!
    var rssItems : [RSSItem] = []
    let rssURL = URL(string:"http://pox.globo.com/rss/g1/ceara/") // -- Your URL here
    
    // MARK -  Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
    }
    
    // MARK - Custom View
    
    fileprivate func customTableView() {
        self.newsTableView.estimatedRowHeight = 260
        self.newsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func hasImageAtIndex(item: RSSItem) -> Bool {
        if item.imgURL != ""{
            return true
        }
        return false
    }
    
    fileprivate func hiddenIndicator() {
        self.viewLoadIndicator.stopAnimating()
        self.viewLoadIndicator.isHidden = true
    }
    
    fileprivate func showView() {
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.hiddenIndicator()
                self.viewLoad.alpha = 0.0
            }, completion: nil)
            self.newsTableView.reloadData()
        })
    }
    
    // MARK - Request
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
            self.showView()
        }
    }
    
}

// MARK - UITableViewDataSource/Delegate

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

            guard let url = URL(string: urlEncoded) else {
                return //be safe
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

