//
//  AuthManager.swift
//  Trafel
//
//  Created by sky on 12/18/21.
//

import FirebaseAuth
import Foundation

struct AuthManager {
    
    private let auth = Auth.auth()
    
    enum AuthError: Error {
        case unknownError
    }
    
    func signUpNewUser(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknownError))
            }
        }
        
        //    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        //        MBProgressHUD.hide(for: self.view, animated: true)
        //        if let error = error {
        //            self.showErrorMessageIfNeeded(text: error.localizedDescription)
        //        } else if let _ = authResult?.user.uid {
        //            // double check to make sure user id is created by firebase
        //            self.delegate?.showMainTabBarController()
        //        }
        //    }
        
    }
    
    func loginUser(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknownError))
            }
        }
        
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//          guard let self = self else { return }
//            MBProgressHUD.hide(for: self.view, animated: true)
//            if let error = error {
//                self.showErrorMessageIfNeeded(text: "\(error.localizedDescription)")
//            } else if let _ = authResult?.user.uid {
//                self.delegate?.showMainTabBarController()
//            }
//        }
    }
    
    func logoutUser() -> Result<Void, Error> {
        
        do {
            try auth.signOut()
            return .success(())
        } catch let error {
            return .failure(error)
        }
        
//        do {
//            try firebaseAuth.signOut()
//            MBProgressHUD.hide(for: self.view, animated: true)
//            PresenterManager.shared.show(vc: .onboarding)
//        } catch(let error) {
//            print(error.localizedDescription)
//            MBProgressHUD.hide(for: self.view, animated: true)
//        }
    }
    
    func resetPassword(withEmail email: String, completion: @escaping (Result<Void, Error>) -> Void) {
     
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
//
//        Auth.auth().sendPasswordReset(withEmail: email) { error in
//          // ...
//        }
    }
    
    func isUserLoggedIn() -> Bool {
        return auth.currentUser != nil
    }
    
}
