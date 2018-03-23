//
//  ViewController.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rssParser : RSSParser!
    let rssURL = URL(string:"http://pox.globo.com/rss/g1/ceara/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rssParser = RSSParser()
        self.rssParser.parseWithContentOfURL(rssURL: rssURL) { (sucess) in
            if sucess{
                print(self.rssParser.rssItems)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

