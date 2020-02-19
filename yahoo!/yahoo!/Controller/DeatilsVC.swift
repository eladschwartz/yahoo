//
//  DeatilsVC.swift
//  yahoo!
//
//  Created by elad schwartz on 03/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import UIKit

class DeatilsVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailsCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "title: \(event.title ?? "")"
        case 1:
            cell.textLabel?.text = "start: \(event.startDate?.toString() ?? "")"
        case 2:
            cell.textLabel?.text = "end: \(event.endDate?.toString() ?? "")"
        case 3:
            if let gusestID = event.gusestID, let guestName = Utils.shared.usersDict[gusestID] {
                cell.textLabel?.text = "Guest Name: \(guestName)"
            } else {
                cell.textLabel?.text = "Guest Name: Not Found"
            }
        case 4:
            cell.textLabel?.text = "Reminder Type: \(event.reminder?.type ?? "")"
        case 5:
            if let minutesBefore = event.reminder?.minutesBefore {
                cell.textLabel?.text = "Reminder minutes Before: " + String(minutesBefore)
            }
        case 6:
            
            if let startDate = event.startDate, let endDate = event.endDate {
                let durationString = Utils.shared.getHoursAndMintesStringFromDates(startDate: startDate, endDate: endDate)
                
                cell.textLabel?.text = "Duration: " + durationString
            }
        default: break
            
        }
        
        return cell
    }
}
