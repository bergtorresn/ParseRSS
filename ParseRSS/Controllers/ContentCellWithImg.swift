//
//  ContentCell.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import UIKit

class ContentCellWithImg: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!    
    @IBOutlet weak var contentImg: UIImageView!
    
    static func customCell(rss: RSSItem, tableView: UITableView, indexPath: IndexPath) -> ContentCellWithImg {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCellWithImg", for: indexPath) as! ContentCellWithImg
        
        cell.titleLabel.text = rss.title
        cell.dateLabel.text = rss.pubDate
        cell.contentLabel.text = rss.description
        
        loadImageWithURLString(rss.imgURL, cell: cell)
        return cell
    }
    
    static func loadImageWithURLString(_ URLString: String, cell: ContentCellWithImg) {
        
        cell.contentImg.image = nil

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.contentImg.image = downloadedImage
                            }
                        }
                    }
                } else {
                    cell.contentImg.image = #imageLiteral(resourceName: "placeholder.png")
                }
            }).resume()
        } else {
            cell.contentImg.image = #imageLiteral(resourceName: "placeholder.png")
        }
    }

}
