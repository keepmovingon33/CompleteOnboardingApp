//
//  LoginViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit
import MBProgressHUD
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    private let isSuccessfulLogin = true
    weak var delegate: OnboardingDelegate?
    
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
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let error = error {
                self.showErrorMessageIfNeeded(text: error.localizedDescription)
            } else if let userId = authResult?.user.uid {
                // double check to make sure user id is created by firebase
                self.delegate?.showMainTabBarController()
                print("userId created: \(userId)")
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // make the keyboard disappeared
        view.endEditing(true)
        // run the loading animation
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 2.0) {
            // hide the loading animation
            MBProgressHUD.hide(for: self.view, animated: true)
            if self.isSuccessfulLogin {
                self.delegate?.showMainTabBarController()
            } else {
                self.errorMessage = "Your password is incorrect. Please try again!"
            }
        }
    }
}
