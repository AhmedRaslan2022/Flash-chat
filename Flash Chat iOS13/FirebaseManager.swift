//
//  Utitlites.swift
//  Flash Chat iOS13
//
//  Created by Macintosh on 21/08/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth

struct FirebaseManager: FirebaseServices  {
//MARK: -                          Register
    func register(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        
    }
//MARK: -                         Sign Out
    func signOut(completion: @escaping ((Error?) -> Void)) {
        
    }
    
  
    
    
//MARK: -                Log In
    
        func login(email: String, password: String, completion: @escaping ((String?, Error?) -> Void)) {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let error = error {
                    completion(nil, error)
                }
                else{
                    completion(authResult?.user.uid, nil)
                }
            }
        }
}
