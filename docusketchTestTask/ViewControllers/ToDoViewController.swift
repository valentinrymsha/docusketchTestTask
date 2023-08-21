import UIKit
import RealmSwift

final class ToDoViewController: UIViewController {
    
    static let identifier = "ToDoVC"
    private let realm = DatabaseManager.realm
    private lazy var tasks: Results<TaskModel> = { realm.objects(TaskModel.self) }()
    
    @IBOutlet private weak var taskTableView: UITableView!
    
    @IBOutlet private weak var addTaskButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.estimatedRowHeight = UITableView.automaticDimension
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskTableView.reloadData()
        
    }
    
    private func setupTableView() {
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
    }
    
    @IBAction private func addTaskButton(_ sender: UIButton) {
        
        guard let taskVC = self.storyboard?.instantiateViewController(identifier: TaskViewController.identifier) as? TaskViewController else {
            return
        }
        
        navigationController?.pushViewController(taskVC, animated: true)
        
    }
}


extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !tasks.isEmpty else {
            return 1 }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.taskTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        if !tasks.isEmpty {
            
            cell.taskLabel.text = tasks.reversed()[indexPath.row].task
            cell.progressImage.isHidden = tasks.reversed()[indexPath.row].done
            
            return cell
        } else {
            cell.progressImage.isHidden = false
            cell.taskLabel.text = "Task will be here!"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if !tasks.isEmpty  {
            let remObject = tasks.reversed()[indexPath.row]
            
            DatabaseManager.write(realm: realm, writeClosure: {
                realm.delete(remObject)
                realm.refresh()
            })
        }
        
        self.taskTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard !tasks.isEmpty else {return}
        DatabaseManager.write(realm: realm, writeClosure: {
            if tasks.reversed()[indexPath.row].done == true {
                tasks.reversed()[indexPath.row].done = false
            } else {
                tasks.reversed()[indexPath.row].done = true
            }
        })
        
        taskTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}



