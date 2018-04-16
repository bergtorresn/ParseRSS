//
//  ContentCellWithoutImg.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 26/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit

class ContentCellWithoutImg: UITableViewCell {

    // MARK - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    //  MARK - Create Cell
    static func customCell(rss: RSSItem, tableView: UITableView, indexPath: IndexPath) -> ContentCellWithoutImg{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCellWithoutImg", for: indexPath) as! ContentCellWithoutImg

        cell.titleLabel.text = rss.title
        cell.contentLabel.text = rss.description
        
        let date = FormattedDate.dateFormmatter(stringDate: rss.pubDate)
        if date != "" {
            cell.dateLabel.text = date
        } else{
            cell.dateLabel.text = rss.pubDate
        }
        
        return cell
    }

}
