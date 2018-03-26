//
//  RSSParser.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 23/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import Foundation

struct RSSItem {
    var title : String
    var description : String
    var pubDate : String
    var imgURL : String
}

class RSSParser: NSObject, XMLParserDelegate {
    
    var rssItems : [RSSItem] = []
    
    var currentElement = ""
    var currentTitle = ""
    var currentDescription = ""
    var currentPubDate = ""
    var currentImgURL = ""
    
    func parseWithContentOfURL(rssURL : URL, with completion: @escaping ([RSSItem]) -> ()) {
        
        URLSession.shared.dataTask(with: rssURL) { (data, response, err) in
            
            guard let data = data else {
                if let error = err {
                    print("***** ERROR \(error.localizedDescription)")
                }
                return
            }
            
            let parse = XMLParser(data: data)
            parse.delegate = self
            if parse.parse(){
                completion(self.rssItems)
            }
            
            }.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.currentElement = elementName
        
        if self.currentElement == "item" {
            self.currentTitle = ""
            self.currentDescription = ""
            self.currentPubDate = ""
            self.currentImgURL = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch self.currentElement {
        case "title": self.currentTitle += string
            break
        case "description":
            let imgURL = Regex.getImgFromContent(string: string)
            if imgURL != "" {
                self.currentImgURL += imgURL
            }
            let contentWithoutTagImg = Regex.removeTagImgFromContent(string: string)
            self.currentDescription += contentWithoutTagImg
            break
        case "pubDate": self.currentPubDate += string
            break
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssItem = RSSItem(title: self.currentTitle, description: self.currentDescription, pubDate: self.currentPubDate, imgURL: self.currentImgURL)
            self.rssItems.append(rssItem)
        }
    }
    
    
    
}
