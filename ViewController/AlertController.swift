//
//  AlertController.swift
//  Realm HM
//
//  Created by Dinar on 14.04.2023.
//

import UIKit

extension UIAlertController {
    
    static func createAlert(with title: String, and message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    func action(taskList: TaskList?, completion: @escaping (String) -> Void) {
        
        let doneButton = taskList == nil ? "Сохранить" : "Редактировать"
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text  else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField(){ textField in
            textField.placeholder = "Task List"
            textField.text = taskList?.name
        }
    }
    
    func action(taskList: Task?, completion: @escaping(String, String) -> Void) {
        
        let doneButton = taskList == nil ? "Сохранить" : "Редактировать"
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newTitle = self.textFields?.first?.text else {return}
            guard !newTitle.isEmpty else {return}
            
            if let newNote = self.textFields?.last?.text, !newNote.isEmpty {
                completion(newTitle, newNote)
            } else {
                completion(newTitle, "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField(){ textField in
            textField.placeholder = "New Task"
            textField.text = taskList?.name
        }
        
        addTextField(){ textField in
            textField.placeholder = "New Note"
            textField.text = taskList?.note
        }
    }
}
