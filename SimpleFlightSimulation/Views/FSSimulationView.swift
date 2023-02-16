//
//  FSSimulationView.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import SwiftUI
import Charts
import LaTeXSwiftUI

struct FSSimulationView: View {
    
    @StateObject var vm: ProjectileViewModel = ProjectileViewModel()
    
    @State private var timestep: Double = 0.001
    
    @State private var mass: Double = 1.0
    @State private var height: Double = 0.0
    @State private var velocity: Double = 5.0
    @State private var angle: Double = 45.0
    @State private var area: Double = 2.0
    
    @State private var isTimerStopped: Bool = false
    @State private var timer: Timer?
    @State private var timeElapsed: Double = 0.0
    
    var body: some View {
        title
        Divider()
        Spacer()
        HSplitView {
            VStack {
                simulatorParameter
                Spacer()
                initialParameter
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .frame(width: 500)
            VStack {
                HStack {
                    simulationButtonGroup
                    Spacer()
                    HStack {
                        distanceTraveledInfo
                        maxHeightInfo
                        finalVelocityInfo
                    }.font(.title2)
                }.padding(10)
                timeElapsedInfo
                Chart(vm.coordinates) { coordinate in
                    PointMark(x: .value("x", coordinate.x), y: .value("y", coordinate.y ))
                }.padding(20)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct FSSimulationView_Previews: PreviewProvider {
    static var previews: some View {
        FSSimulationView()
    }
}

extension FSSimulationView {
    private var title: some View {
        Text("Flight Simulation with atmosphere")
            .bold()
            .font(.largeTitle)
            .padding(.top, 20)
            .padding(.bottom, 10)
    }
    
    private var simulatorParameter: some View {
        VStack {
            Text("Simulator Parameter")
                .font(.title)
                .bold()
                .padding(20)
            Divider()
            HStack {
                Text("Timestep: \(timestep) s")
                    .font(.custom("Arial", size: 20))
                Spacer()
                FSTimestepButton(timestep: $timestep)
            }
            .padding(20)
        }
    }
    
    private var initialParameter: some View {
        VStack {
            Text("Initial Parameter")
                .font(.title)
                .bold()
                .padding(20)
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    Text("Mass: \(mass, specifier: "%.1f")")
                        .font(.custom("Arial", size: 20))
                    LaTeX("$kg$").font(.title2)
                }
                FSButton(value: $mass)
            }.padding(20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Height: \(height)")
                        .font(.custom("Arial", size: 20))
                    LaTeX("$m$").font(.title2)
                }
                FSButton(value: $height)
            }.padding(20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Area: \(area, specifier: "%.1f")").font(.custom("Arial", size: 20))
                    LaTeX("$m^2$").font(.title2)
                }
                    
                FSButton(value: $area)
            }.padding(20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Velocity: \(velocity, specifier: "%.1f")").font(.custom("Arial", size: 20))
                    LaTeX("$m/s$").font(.title2)
                }
                FSButton(value: $velocity)
            }.padding(20)
            VStack(alignment: .leading) {
                Text("Angle: \(angle, specifier: "%.1f") º")
                    .font(.custom("Arial", size: 20))
                FSButton(value: $angle)
            }.padding(20)
        }
    }
    
    private var distanceTraveledInfo: some View {
        Group {
            Text("Distance traveled: \(vm.getDistance(), specifier: "%.2f")")
            LaTeX("$m$")
        }
    }
    
    private var maxHeightInfo: some View {
        Group {
            Text("Max height: \(vm.getMaxHeight(), specifier: "%.2f")")
            LaTeX("$m$")
        }
    }
    
    private var finalVelocityInfo: some View {
        Group {
            Text("Final velocity: \(vm.getFinalVelocity(), specifier: "%.2f")")
            LaTeX("$m/s$")
        }
    }
    
    private var timeElapsedInfo: some View {
        HStack {
            Text("Time elapsed: \(timeElapsed, specifier: "%.2f")")
            LaTeX("$s$")
        }.font(.title2)
    }
    
    private var simulationButtonGroup: some View {
        HStack {
            Button {
                // Input initial motion parameter to the view model
                if !isTimerStopped {
                    vm.inputInitialMotion(
                        initialHeight: height,
                        initialMass: mass,
                        initialVelocity: velocity,
                        initialArea: area,
                        initialAngle: angle,
                        timestamp: timestep
                    )
                }
                // Start the projectile motion every timestep seconds
                timer = Timer.scheduledTimer(withTimeInterval: timestep,
                                             repeats: true) { _ in
                    if !vm.isFinalState {
                        vm.startMotion()
                        timeElapsed += timestep
                    } else {
                        isTimerStopped = false
                        timer?.invalidate()
                    }}
            } label: {
                Text("Start simulation!")
            }
            Button {
                isTimerStopped = true
                timer?.invalidate()
            } label: {
                Text("Stop simulation!")
            }
            Button {
                vm.resetState()
            } label: {
                Text("Reset simulation!")
            }
        }
    }
}
