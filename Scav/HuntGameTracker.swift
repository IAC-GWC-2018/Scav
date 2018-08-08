//
//  HuntGameTrackerViewController.swift
//  Scav
//
//  Created by Chloe Gottleib on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HuntGameTrackerDelegate: class {
    func didComplete(hunt: Hunt)
    func didFind(destination: Destination)
}

class HuntGameTracker {
    
    private let hunt: Hunt
    private let radius: CLLocationDistance
    private var currentDestinationIndex: Int
    private var currentHintIndex: Int
    weak var delegate: HuntGameTrackerDelegate?
    
    private var currentDestination: Destination {
        return hunt.destinations[currentDestinationIndex]
    }
    
    var currentHint: Hint {
        return currentDestination.hints[currentHintIndex]
    }
    
    func nextHint() -> Hint? {
        guard currentDestination.hints.indices.contains(currentHintIndex + 1) else {
            return nil
        }
        
        currentHintIndex += 1
        
        return currentDestination.hints[currentHintIndex]
    }
    
    func previousHint() -> Hint? {
        guard currentDestination.hints.indices.contains(currentHintIndex - 1) else {
            return nil
        }
        
        currentHintIndex -= 1
        
        return currentDestination.hints[currentHintIndex]
    }
    
    init(hunt: Hunt, radius: CLLocationDistance = 50.0) {
        self.hunt = hunt
        self.radius = radius
        self.currentDestinationIndex = 0
        self.currentHintIndex = 0
    }
    
    func update(userLocation: CLLocation) {
        guard userLocation.distance(from: currentDestination.location.clLocation) <= radius else {
            return
        }
        
        if currentDestinationIndex == hunt.destinations.count - 1 {
            delegate?.didComplete(hunt: hunt)
        } else {
            delegate?.didFind(destination: currentDestination)
            currentDestinationIndex += 1
            currentHintIndex = 0
        }
    }
}
