//
//  TasksViewController.swift
//  Realm HM
//
//  Created by Dinar on 15.04.2023.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    
    var taskLists: TaskList!
    
    private var curentTasks: Results<Task>!
    private var completedTasks: Results<Task>!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = taskLists.name
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (addButtonPressed)
        )
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? curentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "В РАБОТЕ" : "ЗАВЕРШЕННЫЕ"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let task = indexPath.section == 0 ? curentTasks[indexPath.row] : completedTasks[indexPath.row]
        content.text = task.name
        content.secondaryText = task.note
        cell.contentConfiguration = content
        return cell
    }
    
    @objc private func addButtonPressed() {
        showAlert()
    }
}
    //MARK: - Extension
extension TasksViewController {
    
    private func showAlert(task: Task? = nil, completion: (() -> Void)? = nil) {
        let title = task != nil ? "Edit task" : "New task"
        
        let alert = UIAlertController.createAlert(with: title, and: "Добавьте новую задачу")
        
        alert.action(taskList: taskLists) { [unowned self] newTitle, newNote in
            if let _ = task, let _ = completion {
                StorageManager.shared.edit(taskLists, newValue: newTitle)
            } else {
                self.save(task: newTitle, with: newNote)
            }
        }
        present(alert, animated: true)
    }
    
    private func save(task: String, with note: String) {
        StorageManager.shared.save(task, note, taskLists) { task in
            let rowIndex = IndexPath(row: curentTasks.index(of: task) ?? 0, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
            
        }
    }
    
    
}
    

