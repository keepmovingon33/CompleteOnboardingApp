//
//  SettingsViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .gray
    }
    
    @IBAction func loggedOutButtonTapped(_ sender: UIBarButtonItem) {
//        let onboardingController = UIStoryboard(name: Constant.Segue.main, bundle: nil).instantiateViewController(identifier: Constant.Segue.onBoardingViewController)
//        guard let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window else { return }
//        window.rootViewController = onboardingController
//        //make transition between two screens
//        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
        // refactor code
        PresenterManager.shared.show(vc: .onboarding)
    }
}
