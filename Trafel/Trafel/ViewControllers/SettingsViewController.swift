//
//  SettingsViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit
import MBProgressHUD

class SettingsViewController: UIViewController {
    
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
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(durationInSeconds: 2.0) {
            // hide loading animation
            MBProgressHUD.hide(for: self.view, animated: true)
            PresenterManager.shared.show(vc: .onboarding)
        }
    }
}
