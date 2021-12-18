//
//  HomeViewController.swift
//  Trafel
//
//  Created by sky on 12/17/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        self.title = Constant.NavigationTitle.home
    }
    
    private func setupView() {
        if let email = Auth.auth().currentUser?.email {
            emailLabel.text = email
        } else {
            emailLabel.text = "The user is not logged in"
        }
    }
}
