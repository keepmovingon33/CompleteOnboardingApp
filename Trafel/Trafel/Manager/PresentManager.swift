//
//  PresentManager.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit

class PresenterManager {
    static let shared = PresenterManager()
    
    private init() {}
    
    enum VC {
        case mainTabBarController
        case onboarding
    }
    
    func show(vc: VC) {
        var viewController: UIViewController
        
        switch vc {
        case .mainTabBarController:
            viewController = UIStoryboard(name: Constant.StoryboardId.main, bundle: nil).instantiateViewController(identifier: Constant.StoryboardId.mainTabBarController)
        case .onboarding:
            viewController = UIStoryboard(name: Constant.StoryboardId.main, bundle: nil).instantiateViewController(identifier: Constant.StoryboardId.onBoardingViewController)
        }
        // because we don't have view in here so we can't write this line of code:
        // let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
