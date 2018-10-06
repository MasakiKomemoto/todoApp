//
//  EditViewController.swift
//  todoApp
//
//  Created by 米本匡希 on 2018/10/06.
//  Copyright © 2018年 米本匡希. All rights reserved.
//

import UIKit

enum ViewStyle {
    case create
    case update
}

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var navigationbar: UINavigationBar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var memoTextView: UITextView!

    var todo: TodoEntity? = nil
    var style: ViewStyle = .create

    deinit {
        print("\(self) was deinited")
    }

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
        navigationbar.delegate = self
        datePicker.addTarget(self, action: #selector(pickerValueChanged(_:)), for: .valueChanged)
        switch style {
        case .create:
            navigationbar.topItem?.title = "新規作成"
            titleTextField.text = ""
            dateLabel.text = datePicker.date.toStringJP()
            memoTextView.text = ""
        case .update:
            navigationbar.topItem?.title = "編集"
            titleTextField.text = todo?.title
            dateLabel.text = todo?.date.toStringJP()
            datePicker.date = todo?.date ?? Date()
            memoTextView.text = todo?.memo ?? "nil"
        }
    }

    @objc func pickerValueChanged(_ sender: UIDatePicker) {
        dateLabel.text = sender.date.toStringJP()
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneAction(_ sender: Any) {
        guard titleTextField.text == "" else {
            switch style {
            case .create:
                TodoModel.create(t: titleTextField.text!, d: datePicker.date, m: memoTextView.text, completion: { _ in
                    let navigationVC = self.presentingViewController as! UINavigationController
                    let indexVC = navigationVC.viewControllers[0] as! IndexViewController
                    indexVC.updateUI()
                })
            case .update:
                TodoModel.update(id: (todo?.id)!, t: titleTextField.text!, d: datePicker.date, m: memoTextView.text, completion: { td in
                    let navigationVC = self.presentingViewController as! UINavigationController
                    let detailVC = navigationVC.topViewController as! DetailViewController
                    detailVC.todo = td
                    detailVC.updateUI()
                })
            }
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
}

extension EditViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}




