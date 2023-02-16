//
//  ProjectileViewModel.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import Foundation

final class ProjectileViewModel: ObservableObject {
    @Published var coordinates: [Coordinate]
    @Published var finalState: Bool = false
    
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
        
        vx = vx - beta/mass * vx * v * dt
        vy = vy - (Constants.g + beta / mass * vy * v) * dt
        
        x = x + vx * dt
        y = y + vy * dt
        
        if y >= 0 {
            let coordinate: Coordinate = Coordinate(x: x, y: y)
            coordinates.append(coordinate)
        } else {
            finalState = true
        }
    }
}
