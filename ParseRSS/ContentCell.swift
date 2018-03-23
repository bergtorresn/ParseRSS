//
//  ContentCell.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!    
    
    func customCell(rss : RSSItem){
        
        self.titleLabel.text = rss.title
        self.dateLabel.text = rss.pubDate
        self.contentLabel.text = rss.description
        print(rss.imgURL)
    }

}
