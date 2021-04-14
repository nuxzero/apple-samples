//
//  DateFormatterUtils.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 24/1/2564 BE.
//

import Foundation

class DateUtils {
    
    static var dateFormatter: DateFormatter {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            // Use format appropriate to your JSON String.  This is for ISO-8601
            // You MUST account for the milliseconds even if you don't want them
            // or it won't parse properly
            dateFormatter.dateFormat = "yy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter
        }
    }
}
