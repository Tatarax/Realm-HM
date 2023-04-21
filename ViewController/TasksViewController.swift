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
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        curentTasks = taskLists.tasks.filter("isComplet = false")
        completedTasks = taskLists.tasks.filter("isComplet = true")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? curentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "АКТИВНЫЕ" : "ЗАВЕРШЕННЫЕ"
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
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = indexPath.section == 0 ? curentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {_,_,_ in
            StorageManager.shared.delete(task: task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { [unowned self] _,_,isDone in
            showAlert(task: task) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
     
        
        let titleDone = indexPath.section == 0 ? "Done" : "Cancel"
        
        let done = UIContextualAction(style: .normal, title: titleDone) { [weak self] _,_, isDone in
            StorageManager.shared.done(task: task)
            
            let curentTaskIndex = IndexPath(row: self?.curentTasks.index(of: task) ?? 0, section: 0)
            
            let completedTaskIndex = IndexPath(row: self?.completedTasks.index(of: task) ?? 0, section: 1)
            
            let rowIndex = indexPath.section == 0 ? completedTaskIndex : curentTaskIndex
            tableView.moveRow(at: indexPath, to: rowIndex)
            
            isDone(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete, edit, done])
    }
}
    //MARK: - Extension
extension TasksViewController {
    
    private func showAlert(task: Task? = nil, completion: (() -> Void)? = nil) {
        let title = task != nil ? "Edit task" : "New task"
        
        let alert = UIAlertController.createAlert(with: title, and: "Добавьте новую задачу")
        
        alert.action(taskList: task) { [unowned self] newTitle, newNote in
            if let task = task, let completion = completion {
                StorageManager.shared.edit(task: task, name: newTitle, note: newNote)
                completion()
            } else {
                self.save(newTitle, with: newNote)
            }
        }
        present(alert, animated: true)
    }
    
    private func save(_ task: String, with note: String) {
        StorageManager.shared.save(task, note, taskLists) { task in
            let rowIndex = IndexPath(row: curentTasks.index(of: task) ?? 0, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
            
        }
    }
    
    
}
    

