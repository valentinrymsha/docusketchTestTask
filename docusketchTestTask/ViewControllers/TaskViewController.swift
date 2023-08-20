import UIKit
import RealmSwift

final class TaskViewController: UIViewController {
    
    static let identifier = "TaskVC"
    private let realm = DatabaseManager.realm
    
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBOutlet private weak var newTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
    }
    
    private func noTextAlert() {
        let alert = UIAlertController(title: "Error:(", message: "You should to write something",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try Again",
                                      style: .default))
        present(alert,animated: true)
    }
    
    private func successTaskAlert() {
        let alert = UIAlertController(title: "Completed!",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey",
                                      style: .default))
        present(alert, animated: true)
    }
    
    @IBAction private func saveNewTaskButton(_ sender: Any) {
        
        guard newTaskTextField.text?.isEmpty != true else {
            return noTextAlert()
        }
        
        let newTask = TaskModel()
        newTask.task = newTaskTextField.text!
        newTask.done = true
        
        DatabaseManager.write(realm: realm, writeClosure: {
            realm.add(newTask)
            realm.refresh()
        })
        
        newTaskTextField.text?.removeAll()
        successTaskAlert()
        
    }
}

extension TaskViewController {
    
 private func initializeHideKeyboard(){
 
     let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,
                                                           action: #selector(dismissMyKeyboard))
     view.addGestureRecognizer(tap)
 }
 @objc func dismissMyKeyboard(){
     view.endEditing(true)
 }
}
