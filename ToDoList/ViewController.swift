//
//  ViewController.swift
//  ToDoList
//
//  Created by Isabel on 02.03.18.
//  Copyright © 2018 MoyaLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    @IBAction func addAction(_ sender: Any) {
        showInputDialog()
    }

    func showInputDialog() {
        let alertController = UIAlertController(title: "Add new activity", message: "Enter your next activity", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in

            let newActivity = alertController.textFields?[0].text
            if (newActivity != nil) && newActivity != "" {
                todoList?.append(newActivity!)
                self.tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }

        alertController.addTextField { (textField) in
            textField.placeholder = "Add more to the list!"
        }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todo = todoList {
            return todo.count
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if let todo = todoList {
            cell.textLabel?.text = todo[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

