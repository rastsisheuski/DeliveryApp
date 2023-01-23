//
//  AuthService.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import Foundation
import FirebaseAuth

class AuthService {
//    static let shared = AuthService()
//
//    private init() { }
//
//    private let auth = Auth.auth()
//    private var verificationID: String?
//    private var currentUser: User? {
//        return auth.currentUser
//    }
//
//    func startAuth(phoneNumber: String, complition: @escaping (Bool) -> Void) {
//        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
//            guard let verificationID = verificationID,
//                  let self,
//                  error == nil else {
//                complition(false)
//                return
//            }
//            self.verificationID = verificationID
//            complition(true)
//        }
//    }
//
//    func verifyCode(smsCode: String, complition: @escaping (Bool) -> Void) {
//        guard let verificationID = verificationID else {
//            complition(false)
//            return
//        }
//
//        let credential = PhoneAuthProvider.provider().credential(
//            withVerificationID: verificationID,
//            verificationCode: smsCode
//        )
//
//        auth.signIn(with: credential) { result, error in
//            guard result != nil,
//                  error == nil else{
//                complition(false)
//                return
//            }
//            complition(true)
//        }
//    }
    
//    func signUP(email: String,
//                password: String,
//                complition: @escaping (Result<User, Error>) -> Void) {
//
//        auth.createUser(withEmail: email, password: password) { result, error in
//            guard result != nil,
//                  error == nil else {
//                complition(.failure(error))
//                return
//            }
//            complition(.success(result?.user))
//        }
//    }
       
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    func createUser(user: UserModel, completionBlock: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: user.email, password: user.password) {(result, error) in
            guard let result else {
                let error = NSError(domain: error?.localizedDescription ?? "", code: 401, userInfo: nil)
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(result))
        }
    }
    
    func signIn(loginUser: LoginUser, completionBlock: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: loginUser.email, password: loginUser.password) { (result,error) in
            guard let result else {
                let error = NSError(domain: error?.localizedDescription ?? "", code: 401, userInfo: nil)
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(result))
        }
    }
}
