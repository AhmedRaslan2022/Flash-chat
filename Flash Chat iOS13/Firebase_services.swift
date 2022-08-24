//
//  Firebase_services.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation


protocol FirebaseServices {
    
    
 
//MARK: -                           Log in
        
        func login(email: String, password: String, completion: @escaping ((String?, Error?) -> Void))
        
        
//MARK: -                          Register
            
        func register(email: String, password: String, completion: @escaping ((Error?) -> Void))
    

//MARK: -                           Sign Out

        func signOut(completion: @escaping ((Error?)-> Void))


}
