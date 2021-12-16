//
//  OnboardingCollectionViewCell.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(image: UIImage) {
        slideImageView.image = image
    }
}
