//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let dp = Firestore.firestore()
    var messages : [Message] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        title = K.appName
        loadMessages()
    }
    
    func loadMessages() {
         
        dp.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ (querySnapshot,error) in
            self.messages = []
            if let error = error {
                print(error)
            }
            else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument{
                        let data = doc.data()
                        if  let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexpath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexpath, at: .top, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text ,let messageSender = Auth.auth().currentUser?.email {
            dp.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print (e)
                }else {
                    print ("Data saved successfuly")
                    self.messageTextfield.text = ""
                }
            }
        }
    }
    
    @IBAction func logoutPresseed(_ sender: UIBarButtonItem) {
        
       do {
         try Auth.auth().signOut()
           navigationController?.popViewController(animated: true)
       } catch let signOutError as NSError {
         print("Error signing out: %@", signOutError)
       }
         
    }

}

//MARK: -      UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel?.text = messages[indexPath.row].body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.rightImageView.isHidden = false
            cell.leftImageView.isHidden  = true
            cell.bubbleView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel?.textColor  = UIColor(named:K.BrandColors.purple)
        }
        else {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden  = false
            cell.bubbleView.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel?.textColor = UIColor(named:K.BrandColors.lightPurple)
          }
    
        return cell
    }
  
}


