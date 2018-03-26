//
//  Regex.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 26/03/18.
//  Copyright © 2018 RTN. All rights reserved.
//

import Foundation

class Regex {
    
    static let pattern = "<img src=\"([^<]+)"
        
    static func getImgFromContent(string: String) -> String{
        
        let regex = self.regexContent(for: pattern, in: string)
        let final = regex.joined().replacingOccurrences(of: "<img src=\"", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " />", with: "")
        return final
        
    }
    
    static func removeTagImgFromContent(string: String) -> String{
        
        let regex = self.regexContent(for: pattern, in: string)
        let tagImg = regex.joined()
        let final = string.replacingOccurrences(of: tagImg, with: "").replacingOccurrences(of: "<br />", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        return final
    }
    
    static func regexContent(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

}
