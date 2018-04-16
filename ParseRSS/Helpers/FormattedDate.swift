//
//  FormattedDate.swift
//  ParseRSS
//
//  Created by Rosemberg Torres Nunes on 16/04/2018.
//  Copyright © 2018 RTN. All rights reserved.
//

import Foundation

class FormattedDate {
    
    static func dateFormmatter(stringDate: String) -> String {
        
        /// Get date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "E, d MMM y HH:mm:ssZ" // Put you date formatter
        
        /// Formatter
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "pt_BR")
        dateFormatterPrint.dateFormat = "dd 'de' MMMM 'de' yyyy 'às' HH:mm:ss"
        
        if let date = dateFormatterGet.date(from: stringDate){
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
    
}
