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
            
            let cookingHomeList = Task(value: ["name : Cooking", "note : Meat"])
            let cleaningHomeList = Task(value: ["name : Cleaning", "note : Room", Date(), true])
            
            let reportWorkList = Task(value: ["name : Report", "note : Work Report"])
            let dinnerWorkList = Task(value: ["name : Dinner", "note : One hours", Date(), true])
            
            homeList.tasks.insert(contentsOf: [cookingHomeList, cleaningHomeList], at: 1)
            workList.tasks.insert(contentsOf: [reportWorkList, dinnerWorkList], at: 1)
            
            DispatchQueue.main.async {
                StorageManager.shared.save([workList, homeList])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
    
    
}
