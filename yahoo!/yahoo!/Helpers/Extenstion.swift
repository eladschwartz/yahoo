//
//  Extenstion.swift
//  yahoo!
//
//  Created by elad schwartz on 03/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let date = self
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        // Parsing the Date from 2019-08-16T08:00:00.000Z to 2019-08-16 08:00
        var newStringDate = ""
        if  minutes == 0 {
            newStringDate = "\(year)-\(month)-\(day) \(hour):00"
        } else if minutes > 9 {
            newStringDate = "\(year)-\(month)-\(day) \(hour):\(minutes)"
        } else {
            newStringDate = "\(year)-\(month)-\(day) \(hour):0\(minutes)"
        }
        
        return newStringDate
    }
}




