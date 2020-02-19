//
//  EventCell.swift
//  yahoo!
//
//  Created by elad schwartz on 03/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(event: Event, isEventToDo: Bool) {
        self.titleLabel.text = event.title ?? ""
        self.timeLabel.text = event.startDate?.toString()
        self.backgroundColor = isEventToDo ? .systemBlue : .clear
    }
}
