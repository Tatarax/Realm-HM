//
//  TaskList.swift
//  Realm HM
//
//  Created by Dinar on 14.04.2023.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @Persisted var name = ""
    @Persisted var tasks = List<Task>()
    @Persisted var date = Date()
}

class Task: Object {
    @Persisted var name = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComplet = false
}
