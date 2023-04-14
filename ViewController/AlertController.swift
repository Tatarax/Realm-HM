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
}
