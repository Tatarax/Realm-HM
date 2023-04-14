//
//  TaskList.swift
//  Realm HM
//
//  Created by Dinar on 14.04.2023.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @Persisted var name: String
    @Persisted var tasks: List<Task>
    @Persisted var date = Date()
}

class Task: Object {
    @Persisted var name: String
    @Persisted var note: String
    @Persisted var date = Date()
    @Persisted var isComplet = false
}
