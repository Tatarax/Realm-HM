//
//  DataStore.swift
//  Realm HM
//
//  Created by Dinar on 17.04.2023.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            let workList = TaskList()
            workList.name = "Working List"
            
            let homeList = TaskList()
            homeList.name = "Home List"
            
            //MARK: - Home Task()
            let cookinHomeTask = Task()
            cookinHomeTask.name = "Cooking"
            cookinHomeTask.note = "Meat"
            
            let cleanHomeTask = Task()
            cleanHomeTask.name = "Cleaning"
            cleanHomeTask.note = "Room"
            cleanHomeTask.date = Date()
            cleanHomeTask.isComplet = true
            
            //MARK: - Work Task()
            let reportWorkTask = Task()
            reportWorkTask.name = "Report"
            reportWorkTask.note = "Work report"
            
            let dinnerWorkTask = Task()
            dinnerWorkTask.name = "Dinner"
            dinnerWorkTask.note = "One hours"
            dinnerWorkTask.date = Date()
            dinnerWorkTask.isComplet = true
            
            homeList.tasks.append(cleanHomeTask)
            homeList.tasks.append(cookinHomeTask)
            workList.tasks.append(reportWorkTask)
            workList.tasks.append(dinnerWorkTask)
            
            DispatchQueue.main.async {
                StorageManager.shared.save([workList, homeList])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
    
    
}

//let cookingHomeList = Task(value: ["name" : "Cooking", "note" : "Meat"])
//let cleaningHomeList = Task(value: ["Cleaning", "Room", Date(), true])


//let reportWorkList = Task(value: ["name" : "Report", "note" : "Work Report"])
//let dinnerWorkList = Task(value: ["Dinner", "One hours", Date(), true])
