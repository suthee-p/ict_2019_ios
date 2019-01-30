//
//  ViewController.swift
//  TODO
//
//  Created by suthee prudchayatanakul on 29/1/2562 BE.
//  Copyright © 2562 organization name. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Variables
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    
    private var todoList: [TodoItem] = [TodoItem]()
    
    // MARK: View lift cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Action
    @IBAction func onAddPress(_ sender: Any) {
        // สร้าง alert dialog
        let alert = UIAlertController(title: nil, message: "เพิ่ม Todo", preferredStyle: .alert)
        
        // ใส่ text input ให้ alert dialog
        alert.addTextField { (textField) in
            textField.placeholder = "ข้อความ"
        }
        
        // เพิ่มปุ่ม ตกลง
        alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: { (action) in
            // ทำอะไรเมื่อกดปุ่ม ตกลง
            // เช็คว่าข้อความที่กรอกเข้ามาไม่ใช่ค่าว่าง
            if let message = alert.textFields![0].text, message.lengthOfBytes(using: .utf8) > 0 {
                // เพิ่มข้อความเข้าไปใน Todo
                self.todoList.append(TodoItem(withMessage: message))
                // สั่ง reload table view
                self.tableView.reloadData()
            }
        }))
        
        // เพิ่มปุ่ม ยกเลิก
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: { (action) in
            // ทำอะไรเมื่อกด ยกเลิก
        }))
        
        // แสดง alert dialog
        self.present(alert, animated: true) {
            
        }
    }

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // มี todo จำนวนกี่อัน
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TableViewCell ที่ใช้แสดง todo แต่ละอัน
        let identifier: String = "MyTableViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let todoItem = self.todoList[indexPath.row]
        cell!.textLabel?.text = todoItem.message
        
        if todoItem.completed {
            cell!.accessoryType = .checkmark
        } else {
            cell!.accessoryType = .none
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // สามารถแก้ไข todo อันไหนได้บ้าง
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // สั่งแก้ไข todo
        self.todoList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // ลักษณะการแก้ไข
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // กดเลือกที่ todo แต่ละอันแล้วทำอะไร
        tableView.deselectRow(at: indexPath, animated: true)
        self.todoList[indexPath.row].completed = !self.todoList[indexPath.row].completed
        self.tableView.reloadData()
    }
}

