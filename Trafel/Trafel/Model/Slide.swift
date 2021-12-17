//
//  Slide.swift
//  Trafel
//
//  Created by sky on 12/16/21.
//

import Foundation

struct Slide {
    let imageName: String
    let title: String
    let description: String
    
    static let collection: [Slide] = [
        Slide(imageName: "imTravel1", title: "Welcome to Trafel", description: "Trafel allows you to travel around the world, make new friends and create memorable experiences."),
        Slide(imageName: "imTravel2", title: "Connect Socially", description: "Connect across continents to strangers via the app"),
        Slide(imageName: "imTravel3", title: "Safe And Secure", description: "Each trip is planned according to the strictest safety standards to ensure passenger safety."),
        Slide(imageName: "imTravel1", title: "Welcome to Trafel", description: "Trafel allows you to travel around the world, make new friends and create memorable experiences.")
    ]
}
