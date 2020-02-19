//
//  Event.swift
//  yahoo!
//
//  Created by elad schwartz on 03/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import Foundation

class EventToDo: Codable {
    var events: [Event]?
    var todos: [ToDo]?
    
    static func saveEventsLocaly(eventsAndToDo: EventToDo) {
        
        do {
            let eventsData = try JSONEncoder().encode(eventsAndToDo)
            UserDefaults.standard.set(eventsData, forKey: "events")
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    static func getEventsLocaly() -> EventToDo? {
        
        if let eventsData = UserDefaults.standard.data(forKey: "events") {
            do {
                let eventToDo = try JSONDecoder().decode(EventToDo.self, from: eventsData)
                return eventToDo
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    init(events: [Event], todos: [ToDo]) {
        self.events = events
        self.todos = todos
    }
}

class Event: Codable {
    
    var startDate : Date?
    var endDate: Date?
    var gusestID: String?
    var title: String?
    var reminder: Reminder?
    
    
    init(startDate: Date, endDate: Date, gusestID: String, title: String, reminder: Reminder?) {
        self.startDate = startDate
        self.endDate = endDate
        self.gusestID = gusestID
        self.title = title
        self.reminder = reminder
    }
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_time"
        case endDate = "end_time"
        case gusestID = "guest_id"
        case title
        case reminder
    }
}

class ToDo: Codable {
    var startDate : Date?
    var title: String?
    var isCompleted: Bool?
    var reminder: Reminder?
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_time"
        case isCompleted = "is_completed"
        case title
        case reminder
    }
    
    init(startDate: Date, title: String, isCompleted: Bool, reminder: Reminder?) {
        self.startDate = startDate
        self.title = title
        self.isCompleted = isCompleted
        self.reminder = reminder
    }
}

class Reminder: Codable {
    var type: String?
    var minutesBefore: Int?
    
    enum CodingKeys: String, CodingKey {
        case minutesBefore = "minutes_before"
        case type
    }
    
    init(type: String, minutesBefore: Int) {
        self.type = type
        self.minutesBefore = minutesBefore
    }
}
