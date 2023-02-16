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
    
    private var timestep: Double = 0.001
    
    private var mass: Double = 1.0
    private var height: Double = 0.0
    private var velocity: Double = 5.0
    private var angle: Double = 45.0
    private var area: Double = 2.0
    
    private var coordinates: [Coordinate] = [
        Coordinate(x: 10.5, y: 4.3),
        Coordinate(x: 3.4, y: 2.5),
        Coordinate(x: 7.5, y: 2.5)
    ]
    
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
                    Button {
                        
                    } label: {
                        Text("Start simulation!")
                    }
                    Button {
                        
                    } label: {
                        Text("Stop simulation!")
                    }
                    Button {
                        
                    } label: {
                        Text("Reset simulation!")
                    }
                }
                .padding(10)
                Chart(coordinates) { coordinate in
                    PointMark(x: .value("x", coordinate.x), y: .value("y", coordinate.y ))
                }
                .padding(20)
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
                FSTimestepButton()
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
                FSButton()
            }.padding(20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Height: \(height)")
                        .font(.custom("Arial", size: 20))
                    LaTeX("$m$").font(.title2)
                }
                FSButton()
            }.padding(20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Area: \(area, specifier: "%.1f")").font(.custom("Arial", size: 20))
                    LaTeX("$m^2$").font(.title2)
                }
                    
                FSButton()
            }.padding(20)
            VStack(alignment: .leading) {
                HStack {
                    Text("Velocity: \(velocity, specifier: "%.1f")").font(.custom("Arial", size: 20))
                    LaTeX("$m/s$").font(.title2)
                }
                FSButton()
            }.padding(20)
            VStack(alignment: .leading) {
                Text("Angle: \(angle, specifier: "%.1f") º")
                    .font(.custom("Arial", size: 20))
                FSButton()
            }.padding(20)
        }
    }
}
