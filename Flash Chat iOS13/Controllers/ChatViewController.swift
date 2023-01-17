//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by MAHFUJ on 5/1/23.
//  Copyright © 2023 MAHFUJ. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    //private, fileprivate,  internal, public
    
    // App Life Cycle
    // View Controller Life Cycle
    
    // Thread: Multi Thread
    // Main Thread
//    BG Thread : System, Custom
    
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var messageTextfield: UITextField!
    
    private let db = Firestore.firestore()
    private var allMessages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        title = "⚡️FlashChat"
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessages()
    }
    
    private func loadMessages() {
        db.collection("messages").order(by: "date").addSnapshotListener { (querySnapshot, error) in
            self.allMessages = []
            if let e = error {
                print("An issue to retrieve data from Firebase, \(e)")
            } else {
                if let snappedDocuments = querySnapshot?.documents {
                    for doc in snappedDocuments {
                        if let messageSender = doc.data()["sender"], let messageBody = doc.data()["body"] {
                            let newMessage = Message(sender: messageSender as! String, body: messageBody as! String)
                            self.allMessages.append(newMessage)
                        }
                    }

                    DispatchQueue.main.async { // it is used to back to forground from background thread & update interface
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row: self.allMessages.count-1, section: 0)
                        self.tableView.scrollToRow(at: indexPath , at: .top, animated: true)
                        //print("reload ****")
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) { // send data
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender" : messageSender,
                "body" : messageBody,
                "date" : Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("there is a complexity to send data, \(e)")
                } else {
                    print("successfully saved data")
                }
            }
        }
        DispatchQueue.main.async {
            self.messageTextfield.text = "" // TextInputField will be blank after getting input
        }
    }
    
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
     }
    }
}

extension ChatViewController: UITableViewDataSource { // numberOfRowsInSection Function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell // cellForRowAt Function
        cell.reload(message: allMessages[indexPath.row])
        return cell
    }

    
}
