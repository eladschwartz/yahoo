//
//  Utils.swift
//  yahoo!
//
//  Created by elad schwartz on 05/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import Foundation

class Utils {
    
    static let shared = Utils()
    
    // Make the users dictionary part of the singletone for using in more then one place
    var usersDict : Dictionary<String, String> = Dictionary<String, String>()
    
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return formatter
    }
    
    func getHoursAndMintesStringFromDates(startDate: Date, endDate: Date) -> String {
        
        let diff =  endDate.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
        let numberOfHours = Int(diff / 3600)
        let numberOfMintues = Int((diff.truncatingRemainder(dividingBy: 3600) / 60))
        
        if numberOfHours < 1 && numberOfMintues >= 1 {
            return "00:\(numberOfMintues)"
        }
        
        if numberOfHours >= 1 {
            if (numberOfMintues <= 9) {
                  return "\(numberOfHours):0\(numberOfMintues)"
            } else {
                  return "\(numberOfHours):\(numberOfMintues)"
            }
          
        }
        
        return "00:00"
    }
    
    
}
