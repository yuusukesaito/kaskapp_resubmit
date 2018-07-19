//
//  InputViewController.swift
//  taskapp
//
//  Created by 理化学Mac on 2018/07/13.
//  Copyright © 2018年 yuusukesaito. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    //categoryの追加
    @IBOutlet weak var categoryTextField: UITextField!
    let realm = try! Realm()
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard));self.view.addGestureRecognizer(tapGesture)
        titleTextField.text = task.title
        contentsTextField.text = task.contents
        datePicker.date = task.date
        //categoryの追加
        categoryTextField.text = task.category
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextField.text
            self.task.date = self.datePicker.date
            //categoryの追加
            self.task.category = self.categoryTextField.text!
            self.realm.add(self.task, update: true)
        }
        setNotification(task: task)
        super.viewWillDisappear(animated)
    }
    
    @objc func dismisskeyboard(){
        view.endEditing(true)
    }
    
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(内容なし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default()
        let calender = Calendar.current
        let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest.init(identifier: String(task.id), content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録 OK")
        }
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

