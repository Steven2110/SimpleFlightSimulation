//
//  FSProjectileModel.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 20.02.2023.
//

import Foundation
import SwiftUI

class FSProjectileObject: Identifiable {
    var id: UUID = UUID()
    var coordinates: [Coordinate] = [Coordinate]()
    var name: String
    
    var mass: Double
    var x: Double = 0.0
    var y: Double
    var area: Double
    var velocity: Double
    var angle: Double
    
    // Computed properties
    var sina: Double
    var cosa: Double
    var beta: Double
    
    var vx: Double = 0.0
    var vy: Double = 0.0
    
    var isFinalState: Bool = false
    
    init(_ number: Int, height: Double, mass: Double, area: Double, velocity: Double, angle: Double) {
        self.name = "Object \(number)"
        
        self.mass = mass
        self.y = height
        self.mass = mass
        self.area = area
        self.velocity = velocity
        self.angle = angle
        
        self.sina = sin(angle * Double.pi / 180)
        self.cosa = cos(angle * Double.pi / 180)
        self.beta = 0.5 * Constants.C * area * Constants.rho
        
        self.vx = self.velocity * cosa
        self.vy = self.velocity * sina
        
        let initialCoordinate: Coordinate = Coordinate(x: self.x, y: self.y)
        coordinates.append(initialCoordinate)
    }
    
    func move(by dt: Double) {
        let v: Double = sqrt(pow(vx, 2) + pow(vy, 2))
        
        let previousVx: Double = vx
        let previousVy: Double = vy
        
        vx = vx - beta/mass * vx * v * dt
        vy = vy - (Constants.g + beta / mass * vy * v) * dt
        
        x = x + vx * dt
        y = y + vy * dt
        
        if y >= 0 {
            let coordinate: Coordinate = Coordinate(x: x, y: y)
            coordinates.append(coordinate)
        } else {
            // Return the calculation for final x and y velocity
            vx = previousVx
            vy = previousVy
            
            isFinalState = true
        }
    }
    
    func getInitialHeight() -> Double {
        coordinates.first?.y ?? 0.0
    }
    
    func getTravelDistance() -> Double {
        coordinates.last?.x ?? 0.0
    }
    
    func getMaxHeight() -> Double {
        coordinates.max { $0.y < $1.y }?.y ?? 0
    }
    
    func getFinalVelocity() -> Double {
        sqrt(pow(vx, 2) + pow(vy, 2))
    }
    
    func getState() -> Bool {
        isFinalState
    }
}
