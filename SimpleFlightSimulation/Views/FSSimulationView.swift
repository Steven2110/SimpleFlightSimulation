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
    
    @State private var showInfo: Bool = false
    @State private var objNumber: Int = 1
    
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
            .frame(width: 450)
            if showInfo { simulationInformation }
            VStack {
                HStack {
                    simulationButtonGroup
                    Spacer()
                }.padding(10)
                timeElapsedInfo
                Chart(vm.projectileObjects, id: \.id) { projectileObject in
                    ForEach(projectileObject.coordinates) { coordinate in
                        PointMark(x: .value("x", coordinate.x), y: .value("y", coordinate.y))
                            .foregroundStyle(by: .value("Obj", projectileObject.name))
                    }
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
            HStack{
                VStack(alignment: .leading) {
                    Text("Timestep: \(timestep) s")
                        .font(.custom("Arial", size: 20))
                    Spacer()
                    FSTimestepButton(timestep: $timestep)
                    Button {
                        vm.setTimestep(timestep)
                    } label: {
                        Text("Set timestep")
                    }
                }
                .padding(.leading, 20)
                Spacer()
            }
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
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Mass: \(mass, specifier: "%.1f")")
                                .font(.custom("Arial", size: 20))
                            LaTeX("$kg$").font(.title2)
                        }
                        FSButton(value: $mass)
                        
                        HStack {
                            Text("Height: \(height)")
                                .font(.custom("Arial", size: 20))
                            LaTeX("$m$").font(.title2)
                        }
                        FSButton(value: $height)
                        
                        HStack {
                            Text("Area: \(area, specifier: "%.1f")").font(.custom("Arial", size: 20))
                            LaTeX("$m^2$").font(.title2)
                        }
                        FSButton(value: $area)
                        
                        HStack {
                            Text("Velocity: \(velocity, specifier: "%.1f")").font(.custom("Arial", size: 20))
                            LaTeX("$m/s$").font(.title2)
                        }
                        FSButton(value: $velocity)
                        
                        Text("Angle: \(angle, specifier: "%.1f") º")
                            .font(.custom("Arial", size: 20))
                        FSButton(value: $angle)
                    }.padding(20)
                    Spacer()
                }
                HStack {
                    Button("Add graph") {
                        withAnimation {
                            showInfo = true
                            vm.inputInitialMotion(
                                objNumber,
                                initialHeight: height,
                                initialMass: mass,
                                initialVelocity: velocity,
                                initialArea: area,
                                initialAngle: angle
                            )
                            objNumber += 1
                        }
                    }.padding(.leading, 20)
                    Spacer()
            }
            }
        }
    }

    private var simulationInformation: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10){
                ForEach(vm.projectileObjects) { projectileObject in
                    Text(projectileObject.name).bold().font(.title3)
                    Divider()
                    // Initial parameter information
                    Group {
                        HStack {
                            Text("Mass: \(projectileObject.mass, specifier: "%.1f")")
                            LaTeX("$kg$")
                        }
                        HStack {
                            Text("Initial height: \(projectileObject.getInitialHeight(), specifier: "%.1f")")
                            LaTeX("$m$")
                        }
                        HStack {
                            Text("Initial Velocity: \(projectileObject.velocity, specifier: "%.1f")")
                            LaTeX("$m/s$")
                        }
                        HStack {
                            Text("Area: \(projectileObject.area, specifier: "%.1f")")
                            LaTeX("$m^2$")
                        }
                        Text("Angle: \(projectileObject.angle, specifier: "%.1f")º")
                    }
                    Divider()
                    // Result/simulation analysis information
                    Group {
                        HStack {
                            Text("Distance: \(projectileObject.getTravelDistance(), specifier: "%.2f")")
                            LaTeX("$m$")
                        }
                        HStack {
                            Text("Max height: \(projectileObject.getMaxHeight(), specifier: "%.2f")")
                            LaTeX("$m$")
                        }
                        HStack {
                            Text("Final velocity: \(projectileObject.getFinalVelocity(), specifier: "%.2f")")
                            LaTeX("$m/s$")
                        }
                    }.padding(.bottom, 10)
                }
            }.padding(5)
        }.frame(width: 175)
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
                if vm.projectileObjects.count == 0 {
                    withAnimation {
                        showInfo = true
                        vm.inputInitialMotion(
                            objNumber,
                            initialHeight: height,
                            initialMass: mass,
                            initialVelocity: velocity,
                            initialArea: area,
                            initialAngle: angle
                        )
                        objNumber += 1
                    }
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
                    }
                }
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
                withAnimation(.easeOut) {
                    timer = nil
                    isTimerStopped = false
                    timeElapsed = 0.0
                    objNumber = 1
                    showInfo = false
                    vm.resetState()
                }
            } label: {
                Text("Reset simulation!")
            }
        }
    }
}
