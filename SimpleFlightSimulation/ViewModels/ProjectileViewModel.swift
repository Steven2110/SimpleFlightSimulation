//
//  ProjectileViewModel.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import Foundation

final class ProjectileViewModel: ObservableObject {
    @Published var projectileObjects: [FSProjectileObject] = [FSProjectileObject]()
    @Published var isFinalState: Bool = false

    private var t: Double = 0.0
    private var dt: Double = 0.001
    
    func setTimestep(_ timestep: Double) {
        self.dt = timestep
    }
    
    func inputInitialMotion(
        _ num: Int,
        initialHeight y0: Double,
        initialMass m: Double,
        initialVelocity v: Double,
        initialArea area: Double,
        initialAngle a: Double
    ) {
        let projectileObject: FSProjectileObject = FSProjectileObject(num, height: y0, mass: m, area: area, velocity: v, angle: a)
        projectileObjects.append(projectileObject)
    }
    
    func startMotion() {
        t += dt
        var isCurrentStateFinal: [Bool] = [Bool]()
        for projectileObj in projectileObjects {
            projectileObj.move(by: dt)
            isCurrentStateFinal.append(projectileObj.getState())
        }
        isFinalState = !isCurrentStateFinal.contains(false)
    }
    
    func resetState() {
        DispatchQueue.main.async { [self] in
            projectileObjects = [FSProjectileObject]()
            isFinalState = false
        }
    }
}
