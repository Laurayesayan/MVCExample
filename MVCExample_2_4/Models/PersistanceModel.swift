//
//  PersistanceModel.swift
//  MVCExample_2_4
//
//  Created by Лаура Есаян on 12.03.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import Foundation
import RealmSwift

 class Tasks: Object {
    @objc dynamic var task = ""
}

 class RealmPersistance {
    static let shared = RealmPersistance()
    private var newTask = ""
    private var tasksList: [String] = []

    private let realm = try! Realm()

    func getRecoordedTask() -> [String] {
        tasksList = []
        for t in realm.objects(Tasks.self) {
            tasksList.append(t.task)
        }

        return tasksList.reversed()
    }

    func setTask(newTask: String) {
        self.newTask = newTask
    }

    func recordTask() {
        try! realm.write {
            let task = Tasks()
            task.task = newTask
            realm.add(task)
        }
    }

    func deleteTask(toDelete: String) {
        for task in realm.objects(Tasks.self) {
            if toDelete == task.task {
                try! realm.write {
                    realm.delete(task)
                }
            }
        }

        tasksList = []
    }
}
