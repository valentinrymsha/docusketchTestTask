//
//  TaskViewController.swift
//  docusketchTestTask
//
//  Created by Valentin on 19.08.23.
//

import UIKit
import RealmSwift


class TaskViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    @IBAction func saveNewTaskButton(_ sender: Any) {
    
        guard newTaskTextField.text?.isEmpty != true else {
            return noTextAlert()
        }
        
        let newTask = Task()
        newTask.task = newTaskTextField.text!
        newTask.done = true
        
        try! realm.write {
            realm.add(newTask)
            realm.refresh()
        }
        
        newTaskTextField.text?.removeAll()
        successTaskAlert()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        
    }
    
    func noTextAlert() {
        let alert = UIAlertController(title: "Error:(", message: "You should to write something",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try Again",
                                      style: .default))
        present(alert,animated: true)
    }
    
    func successTaskAlert() {
        let alert = UIAlertController(title: "Completed!",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey",
                                      style: .default))
        present(alert, animated: true)
    }
    
}
