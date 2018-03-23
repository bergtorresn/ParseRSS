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
}

class RSSParser: NSObject, XMLParserDelegate {
 
    var rssItems : [RSSItem] = []
    
    var currentElement = ""
    var currentTitle = ""
    var currentDescription = ""
    var currentPubDate = ""
    
    func parseWithContentOfURL(rssURL : URL, with completion: @escaping (Bool) -> ()) {
        
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
                completion(true)
            }
            
        }.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.currentElement = elementName
        
        if self.currentElement == "item" {
            self.currentTitle = ""
            self.currentDescription = ""
            self.currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch self.currentElement {
            case "title": self.currentTitle += string
            case "description": self.currentDescription += string
            case "pubDate": self.currentPubDate += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            self.rssItems.append(rssItem)
        }
    }
    
    
    
}
