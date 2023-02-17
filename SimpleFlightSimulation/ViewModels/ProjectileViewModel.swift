//
//  ProjectileViewModel.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import Foundation

final class ProjectileViewModel: ObservableObject {
    @Published var coordinates: [Coordinate]
    @Published var isFinalState: Bool = false
    
    private var x: Double = 0.0
    private var y: Double = 0.0
    
    private var mass: Double = 0.0
    private var area: Double = 0.0
    private var angle: Double = 0.0
    private var velocity: Double = 0.0
    
    private var vx: Double = 0.0
    private var vy: Double = 0.0
    
    private var sina: Double = 0.0
    private var cosa: Double = 0.0
    
    private var t: Double = 0.0
    private var dt: Double = 0.0
    
    private var beta: Double = 0.0
    
    init() {
        self.coordinates = [Coordinate]()
    }
    
    func inputInitialMotion(
        initialHeight y0: Double,
        initialMass m: Double,
        initialVelocity v: Double,
        initialArea area: Double,
        initialAngle a: Double,
        timestamp dt: Double
    ) {
        self.y = y0
        
        self.mass = m
        self.area = area
        self.velocity = v
        self.angle = a * Double.pi / 180
        
        self.dt = dt
        
        sina = sin(angle)
        cosa = cos(angle)
        
        beta = 0.5 * Constants.C * area * Constants.rho
        
        vx = velocity * cosa
        vy = velocity * sina
        
        let coordinate: Coordinate = Coordinate(x: x, y: y)
        coordinates.append(coordinate)
    }
    
    func startMotion() {
        t += dt
        let v: Double = sqrt(pow(vx, 2) + pow(vy, 2))
        
        // Save previous vx and vy for finding final velocity a moment (timestep) before it hit the ground
        let previousVx: Double = vx
        let previousVy: Double = vy
        
        vx = vx - beta/mass * vx * v * dt
        vy = vy - (Constants.g + beta / mass * vy * v) * dt
        
        x = x + vx * dt
        y = y + vy * dt
        print(y)
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
    
    func resetState() {
        x = 0.0
        y = 0.0
        mass = 0.0
        area = 0.0
        angle = 0.0
        velocity = 0
        vx = 0.0
        vy = 0.0
        sina = 0.0
        cosa = 0.0
        t = 0.0
        dt = 0.0
        beta = 0.0
        
        DispatchQueue.main.async { [self] in
            coordinates = [Coordinate]()
            isFinalState = false
        }
    }
    
    func getDistance() -> Double {
        x
    }
    
    func getMaxHeight() -> Double {
        coordinates.max { $0.y < $1.y }?.y ?? 0
    }
    
    func getFinalVelocity() -> Double {
        sqrt(pow(vx, 2) + pow(vy, 2))
    }
}
