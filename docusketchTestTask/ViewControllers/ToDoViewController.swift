//
//  ViewController.swift
//  docusketchTestTask
//
//  Created by Valentin on 18.08.23.
//

import UIKit
import RealmSwift

class ToDoViewController: UIViewController {

    // MARK: Variables, Constans

    let realm = try! Realm()
    lazy var tasks: Results<Task> = { realm.objects(Task.self) }()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var taskTableView: UITableView!
    
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    
    // MARK: VC Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupTableView()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskTableView.reloadData()
        
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "TaskViewController") as? TaskViewController else {
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func setupTableView() {
        
        taskTableView.backgroundColor = #colorLiteral(red: 0.7195360065, green: 0.8872611523, blue: 0.5936881304, alpha: 1).withAlphaComponent(0.2)
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
    }
}

// MARK: Extensions

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard !tasks.isEmpty else {
//            return 1 }
//        return tasks.count
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !tasks.isEmpty {
            return tasks.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 2
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.taskTableView.dequeueReusableCell(withIdentifier: "cell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        cell.layer.cornerRadius = 10
        
        if !tasks.isEmpty {
            
            cell.taskLabel.text = tasks.reversed()[indexPath.section].task
            cell.progressImage.isHidden = tasks.reversed()[indexPath.section].done
            cell.backgroundColor = #colorLiteral(red: 0.7195360065, green: 0.8872611523, blue: 0.5936881304, alpha: 1).withAlphaComponent(0.6)
            
            
            return cell
        } else {
            return self.taskTableView.dequeueReusableCell(withIdentifier: "cell")!
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if !tasks.isEmpty  {
            let remObject = tasks.reversed()[indexPath.section]
            try! realm.write{
                
                realm.delete(remObject)
                realm.refresh()
                
            }
        }
        
        self.taskTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard !tasks.isEmpty else {return}
        try! realm.write {
            if tasks.reversed()[indexPath.section].done == true {
                tasks.reversed()[indexPath.section].done = false
            } else {
                tasks.reversed()[indexPath.section].done = true
            }
//            tasks.reversed()[indexPath.section].done = false
            
        }
        
        taskTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}
