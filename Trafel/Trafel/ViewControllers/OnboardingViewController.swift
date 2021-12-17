//
//  OnboardingViewController.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit

protocol OnboardingDelegate: AnyObject {
    func showMainTabBarController()
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        setupPageControl()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .systemGray6
        // let cell snap to next item
        collectionView.isPagingEnabled = true
        // don't want to show scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Constant.Segue.showLoginSignup, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segue.showLoginSignup {
            guard let destination = segue.destination as? LoginViewController else { return }
            destination.delegate = self
        }
    }
    
    private func showCaption(atIndex index: Int) {
        let slide = Slide.collection[index]
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
        pageControl.currentPage = index
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = Slide.collection.count
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.ReusableIdentifier.onboardingCollectionViewCell, for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = Slide.collection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    // don't want to have space between cell items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
        showCaption(atIndex: index)
    }
}

extension OnboardingViewController: OnboardingDelegate {
    func showMainTabBarController() {
        // Dismiss Login screen
        // show Main TabBar Controller
        if let loginViewController = self.presentedViewController as? LoginViewController {
            loginViewController.dismiss(animated: true) {
                PresenterManager.shared.show(vc: .mainTabBarController)
            }
        }
    }
}
