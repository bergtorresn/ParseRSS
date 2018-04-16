//
//  ContentCell.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit
import SDWebImage

class ContentCellWithImg: UITableViewCell {

    // MARK - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!    
    @IBOutlet weak var contentImg: UIImageView!
    
    // MARK - Create Cell

    
    static func customCell(rss: RSSItem, tableView: UITableView, indexPath: IndexPath) -> ContentCellWithImg {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCellWithImg", for: indexPath) as! ContentCellWithImg
        
        let date = FormattedDate.dateFormmatter(stringDate: rss.pubDate)
        if date != "" {
            cell.dateLabel.text = date
        } else{
            cell.dateLabel.text = rss.pubDate
        }
        
        cell.titleLabel.text = rss.title
        cell.contentLabel.text = rss.description
        
        loadImageWithURL(urlImg: rss.imgURL, cell: cell)
        
        return cell
    }
    
    /// Load image from URL
    static func loadImageWithURL(urlImg: String, cell: ContentCellWithImg) {
        
        cell.contentImg.sd_setImage(with: URL(string: urlImg), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: SDWebImageOptions.continueInBackground) { (img, err, type, url) in
            if let error = err {
                fatalError("***** loadImageWithURL: \(error)")
            }
        }
    }

}
