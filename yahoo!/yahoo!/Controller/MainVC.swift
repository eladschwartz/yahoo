//
//  MainVC.swift
//  yahoo!
//
//  Created by elad schwartz on 06/12/2019.
//  Copyright © 2019 elad schwartz. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var goToEventsBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToEventsBtn.layer.cornerRadius = 10
    }
    

    @IBAction func goToEventsBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToEvents", sender: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToEvents") {
           let vc =  segue.destination as! EventsVC
            if let text = self.textField.text {
                  vc.userNameTitle = text.isEmpty ? "No Name" : self.textField.text
            }
        }
    }
}
