//
//  LoginViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import Loaf
import MBProgressHUD
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    weak var delegate: OnboardingDelegate?
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewFor(pageType: currentPageType)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // keyboard will appear on emailTextField
        emailTextField.becomeFirstResponder()
    }
    
    private enum PageType {
        case login
        case signUp
    }
    
    private var errorMessage: String? {
        didSet {
            showErrorMessageIfNeeded(text: errorMessage)
        }
    }
    
    private var currentPageType: PageType = .login {
        didSet {
            setupViewFor(pageType: currentPageType)
        }
    }
    
    private func setupViewFor(pageType: PageType) {
        errorMessage = nil
        passwordConfirmationTextField.isHidden = pageType == .login
        signUpButton.isHidden = pageType == .login
        forgetPasswordButton.isHidden = pageType == .signUp
        loginButton.isHidden = pageType == .signUp
    }
    
    private func showErrorMessageIfNeeded(text: String?) {
        errorLabel.isHidden = text == nil
        errorLabel.text = text
    }
    
    @IBAction func forgetPasswordButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Forget Password", message: "Please enter your email address.", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let textField = alertController.textFields?.first, let email = textField.text, !email.isEmpty { 
                self.authManager.resetPassword(withEmail: email) { result in
                    switch result {
                    case .success:
                        self.showAlert(title: "Password Reset Successfully", message: "Please check your new Password in your email")
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .top, sender: self).show()
                    }
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              let passwordConfirmation = passwordConfirmationTextField.text,
              !passwordConfirmation.isEmpty else {
                showErrorMessageIfNeeded(text: "Invalid form")
                return }
        
        guard password == passwordConfirmation else {
            showErrorMessageIfNeeded(text: "Password doesn't match")
            return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            MBProgressHUD.hide(for: self.view, animated: true)
//            if let error = error {
//                self.showErrorMessageIfNeeded(text: error.localizedDescription)
//            } else if let _ = authResult?.user.uid {
//                // double check to make sure user id is created by firebase
//                self.delegate?.showMainTabBarController()
//            }
//        }
        
        // refactor with AuthManager
        authManager.signUpNewUser(withEmail: email, password: password) { [weak self] result in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
            switch result {
            case .success:
                self.delegate?.showMainTabBarController()
            case .failure(let error):
                self.showErrorMessageIfNeeded(text: error.localizedDescription)
            }
        }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // make the keyboard disappeared
        view.endEditing(true)
        // run the loading animation
        
        
//        delay(durationInSeconds: 2.0) {
//            // hide the loading animation
//            MBProgressHUD.hide(for: self.view, animated: true)
//            if self.isSuccessfulLogin {
//                self.delegate?.showMainTabBarController()
//            } else {
//                self.errorMessage = "Your password is incorrect. Please try again!"
//            }
//        }
        
        // using firebase
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty else {
                showErrorMessageIfNeeded(text: "Invalid form")
                return
                }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        authManager.loginUser(withEmail: email, password: password) { [weak self] result in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
            switch result {
            case .success:
                self.delegate?.showMainTabBarController()
            case .failure(let error):
                self.showErrorMessageIfNeeded(text: error.localizedDescription)
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
}
