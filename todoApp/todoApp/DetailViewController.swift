//
//  DetailViewController.swift
//  todoApp
//
//  Created by 米本匡希 on 2018/10/06.
//  Copyright © 2018年 米本匡希. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!

    var todo: TodoEntity? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup() {
        navigationItem.title = "詳細"
        navigationController?.delegate = self
        updateUI()
    }

    @IBAction func editAction(_ sender: Any) {
        let updateVC = storyboard?.instantiateViewController(withIdentifier: "create&edit") as! EditViewController
        updateVC.style = .update
        updateVC.todo = todo
        present(updateVC, animated: true, completion: nil)
    }

    @IBAction func deleteAction(_ sender: Any) {
        TodoModel.delete(id: (todo?.id)!, completion: { _ in
            print("delete was tapped")
            let indexVC = self.navigationController?.viewControllers[0] as! IndexViewController
            indexVC.updateUI()
        })
        navigationController?.popViewController(animated: true)
    }

    func updateUI() {
        titleLabel.text = todo?.title ?? "nil"
        dateLabel.text = todo?.date.toStringJP() ?? "nil"
        memoTextView.text = todo?.memo ?? "nil"
        navigationController?.isToolbarHidden = false
    }


}

extension DetailViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let indexVC = viewController as? IndexViewController else { return }
        indexVC.updateUI()
    }
}
