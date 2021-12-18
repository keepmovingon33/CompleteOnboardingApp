//
//  SettingsViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import Loaf
import MBProgressHUD
import UIKit

class SettingsViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()

    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constant.NavigationTitle.settings
    }
    
    
    @IBAction func loggedOutButtonTapped(_ sender: UIBarButtonItem) {
//        let onboardingController = UIStoryboard(name: Constant.Segue.main, bundle: nil).instantiateViewController(identifier: Constant.Segue.onBoardingViewController)
//        guard let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window else { return }
//        window.rootViewController = onboardingController
//        //make transition between two screens
//        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
        // refactor code
        
        // show loading animation
//        MBProgressHUD.showAdded(to: view, animated: true)
//        delay(durationInSeconds: 2.0) {
//            // hide loading animation
//            MBProgressHUD.hide(for: self.view, animated: true)
//            PresenterManager.shared.show(vc: .onboarding)
//        }
        
        // Using Firebase Auth
        
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 1.0) { [weak self] in
            guard let self = self else { return }
            let result = self.authManager.logoutUser()
            switch result {
            case .success:
                PresenterManager.shared.show(vc: .onboarding)
            case .failure(let error):
                Loaf(error.localizedDescription, state: .error, location: .top, sender: self).show()
            }
            MBProgressHUD.hide(for: self.view, animated: true)
            
//            do {
//                try firebaseAuth.signOut()
//                MBProgressHUD.hide(for: self.view, animated: true)
//                PresenterManager.shared.show(vc: .onboarding)
//            } catch(let error) {
//                print(error.localizedDescription)
//                MBProgressHUD.hide(for: self.view, animated: true)
//            }
        }
    }
}
