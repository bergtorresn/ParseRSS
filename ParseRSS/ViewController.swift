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
    
    // -- Variables
    var rssParser : RSSParser!
    var rssItems : [RSSItem] = []
    let rssURL = URL(string:"")!
    
    // -- Lifecile ViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.newsTableView.estimatedRowHeight = 140
        self.newsTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
    }
    
    fileprivate func parse() {
        self.rssParser = RSSParser()
        self.rssParser.parseWithContentOfURL(rssURL: rssURL) { (items) in
            for item in items{
                self.rssItems.append(item)
            }
            
            DispatchQueue.main.async(execute: {
                self.newsTableView.reloadData()
            })
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.newsTableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentCell
        
        cell.customCell(rss: self.rssItems[indexPath.row])
        
        return cell
        
    }
    
}

