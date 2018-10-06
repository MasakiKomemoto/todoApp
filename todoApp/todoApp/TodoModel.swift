//
//  TodoModel.swift
//  todoApp
//
//  Created by 米本匡希 on 2018/10/06.
//  Copyright © 2018年 米本匡希. All rights reserved.
//

import Foundation
import RealmSwift

//DAOとか言われるやつ
class TodoModel {
    //    それぞれの引数にあるcompletionはdbの操作を行った後にControllerが行う処理を(ViewControllerにて)書く

    class func read(completion: @escaping (Results<TodoEntity>) -> Void) {
        let realm = try! Realm()
        let todos = realm.objects(TodoEntity.self)
        completion(todos)
    }

    //    class func create(t: String, d: Date, m: String, completion: @escaping (TodoEntity) -> Void) {
    //        let id = (todos.last?.id ?? 0) + 1
    //        let todo = TodoEntity(id, t, d, m)
    //        todos.append(todo)
    //        completion()
    //
    //    }

    class func create(t: String, d: Date, m: String, completion:  @escaping (TodoEntity) -> Void) {
        let realm = try! Realm()
        let id = (realm.objects(TodoEntity.self).last?.id ?? 0) + 1
        var todo: TodoEntity = TodoEntity()
        try! realm.write {
            todo = realm.create(TodoEntity.self, value: ["id":id,"title":t, "date":d,"memo":m], update: false)
        }
        completion(todo)
    }

    class func update(id: Int, t: String, d: Date, m: String, completion: @escaping (TodoEntity?) -> Void){
        let realm = try! Realm()
        guard let todo = realm.objects(TodoEntity.self).first(where: {$0.id == id}) else {  return }
        try! realm.write {
            todo.title = t
            todo.date = d
            todo.memo = m
        }
        completion(todo)
    }

    class func delete(id: Int, completion: @escaping (TodoEntity) -> Void) {
        let realm = try! Realm()
        guard let todo = realm.objects(TodoEntity.self).first(where: { $0.id == id }) else { return }
        try! realm.write {
            realm.delete(todo)
        }
        completion(todo)
    }
}
