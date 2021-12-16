//
//  LoadingViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private var isUserLoggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(durationInSeconds: 2.0) {
            self.showInitialView()
        }
    }

    private func showInitialView() {
        // if user is logged in => Main tab bar ViewController
        // else => show onboarding ViewController
        
        if isUserLoggedIn {
//            let mainTabBarController = UIStoryboard(name: Constant.Segue.main, bundle: nil).instantiateViewController(identifier: Constant.Segue.mainTabBarController)
//            guard let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window else { return }
//            window.rootViewController = mainTabBarController
            
            //refactor code
            PresenterManager.shared.show(vc: .mainTabBarController)
        } else {
            performSegue(withIdentifier: Constant.Segue.showOnboarding, sender: nil)
        }
        
        
    }
}
