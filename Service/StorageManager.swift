//
//  StorageManager.swift
//  Realm HM
//
//  Created by Dinar on 14.04.2023.
//

import Foundation
import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task List
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(taskList: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskList])
            realm.add(taskList)
            completion(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplet")
        }
    }
    
    //MARK: - Task
    func save(_ task: String, _ note: String, _ taskList: TaskList, completion: (Task) -> Void) {
        let task = Task(value: [task, note])
        taskList.tasks.append(task)
        completion(task)
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    func delete(task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func done(task: Task) {
        write {
            task.setValue(true, forKey: "isComplet")
        }
    }
    
    func edit(task: Task, name: String, note: String) {
        write {
            task.name = name
            task.note = note
        }
    }
    
}
