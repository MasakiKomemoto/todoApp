//
//  IndexViewController.swift
//  todoApp
//
//  Created by 米本匡希 on 2018/10/06.
//  Copyright © 2018年 米本匡希. All rights reserved.
//

import UIKit
import RealmSwift

class IndexViewController: UIViewController {



    @IBOutlet weak var todoTableView: UITableView!
    //    var todos: [Todo] = []
    var todos: Results<TodoEntity>!
    deinit {
        print("\(self) was deinited")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do anvardditional setup after loading thevarew, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    func setup() {
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }

    @IBAction func toCreateView(_ sender: Any) {
        let createVC = self.storyboard?.instantiateViewController(withIdentifier: "create&edit") as! EditViewController
        createVC.style = .create
        present(createVC, animated: true, completion: nil)
    }

    

    func updateUI() {
        navigationController?.isToolbarHidden = true
        TodoModel.read(completion: { tds in
            self.todos = tds
        })
        todoTableView.reloadData()
    }
}

extension IndexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        cell.setup(title: todos[indexPath.item].title, date: todos[indexPath.item].date)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        detailVC.todo = todos[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }



}
