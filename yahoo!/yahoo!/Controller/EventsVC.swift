//
//  ViewController.swift
//  yahoo!
//
//  Created by elad schwartz on 03/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import UIKit

class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let serialQueue = DispatchQueue(label: "com.queue.yahoo!")
    var eventsAndsTodo : EventToDo?
    var userNameTitle: String!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userNameTitle
        getUsersFromServer()
        loadEventsAndToDosFromLocal()
    }
    
    func getUsersFromServer() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        // First get users names from API
        serialQueue.async {
            ApiServer().getUsers { (result ) in
                switch result {
                case .success(let users) :
                    Utils.shared.usersDict = users["users"] ?? Dictionary<String, String>()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
     // Check if Events are stored localy, if true take events localy, else take events from server
    func loadEventsAndToDosFromLocal() {
        if let eventsAndToDoLocaly = EventToDo.getEventsLocaly() {
            self.eventsAndsTodo = eventsAndToDoLocaly
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
            return
        }
        
        getEventsAndToDosFromServer()
    }
    
    func getEventsAndToDosFromServer() {
        serialQueue.async {
            ApiServer().getEventsAndTodos { (result) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
                switch result {
                case .success(let eventsToDo) :
                    // just add random Todo so we can test it on event
                    eventsToDo.todos?.append(self.createRandomToDo())
                    if let events = eventsToDo.events {
                        eventsToDo.events = self.sortEventsArray(events: events)
                    }
                    
                    
                    self.eventsAndsTodo = eventsToDo
                    EventToDo.saveEventsLocaly(eventsAndToDo: eventsToDo)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsAndsTodo?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        if let event = self.eventsAndsTodo?.events?[indexPath.row] {
            if let toDoArray = self.eventsAndsTodo?.todos {
                // check if the date of the ToDo object == date of  Event object
                if let _ = toDoArray.firstIndex(where: { $0.startDate == event.startDate }) {
                    cell.setupCell(event: event, isEventToDo: true)
                } else {
                    cell.setupCell(event: event, isEventToDo: false)
                }
            } else {
                cell.setupCell(event: event, isEventToDo: false)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let titleText = self.eventsAndsTodo?.events?[indexPath.row].title ?? ""
        let timeText = self.eventsAndsTodo?.events?[indexPath.row].startDate?.toString() ?? ""
        
        return calculateLabelHeight(text: titleText) + calculateLabelHeight(text: timeText) + 61
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = self.eventsAndsTodo?.events?[indexPath.row] {
            performSegue(withIdentifier: "goToDetails", sender: event )
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DeatilsVC
        {
            let vc = segue.destination as? DeatilsVC
            vc?.event = sender as? Event
        }
    }
    
    func createRandomToDo() -> ToDo {
        return ToDo(startDate: Utils.shared.dateFormatter.date(from: "2019-08-11T10:00:00.000Z")!, title: "testToDo", isCompleted: true, reminder: nil)
    }
    
    func calculateLabelHeight(text: String) -> CGFloat {
        let label = UILabel(frame: .init(x: 0, y: 0, width: self.view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        return label.frame.height
    }
    
    func sortEventsArray(events: [Event]) -> [Event] {
        let sortedArray = events.sorted {
            if let startDate1 = $0.startDate, let startDate2 = $1.startDate {
                return startDate1 < startDate2
            }
            return false
        }
        return sortedArray
    }
}

