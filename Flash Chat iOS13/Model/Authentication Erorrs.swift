//
//  AuthenticationErorrs.swift
//  Flash Chat iOS13
//
//  Created by Macintosh on 29/08/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct AuthenticationErrorsHandler {
    
    func errorsHandler(error: FirebaseAuth.AuthErrorCode)-> String{
        let errorMessage: String
        switch error.code {
            case AuthErrorCode.wrongPassword:
            errorMessage = "Wrong password"
            case AuthErrorCode.invalidEmail:
            errorMessage = "Invalid email"
            case AuthErrorCode.accountExistsWithDifferentCredential:
            errorMessage = "The account already exists"
            case AuthErrorCode.networkError:
            errorMessage = "Check Network Connection"
            case AuthErrorCode.nullUser:
            errorMessage = "Enter your email address"
            default:
            errorMessage = "unknown error: \(error.localizedDescription)"

        }
        return errorMessage
    }
}
