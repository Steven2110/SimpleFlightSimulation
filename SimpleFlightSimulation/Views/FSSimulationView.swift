//
//  FSSimulationView.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import SwiftUI
import Charts

struct FSSimulationView: View {
    
    private var timestep: Double = 0.001
    
    private var weight: Double = 1.0
    private var height: Double = 0.0
    private var velocity: Double = 5.0
    private var angle: Double = 45.0
    
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
                Chart {
                    PointMark(x: .value("x", 2.5), y: .value("y", 3.5))
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
                Text("Weight: \(weight, specifier: "%.1f") m")
                    .font(.custom("Arial", size: 20))
                FSButton()
            }.padding(20)
            VStack(alignment: .leading) {
                Text("Height: \(height) m")
                    .font(.custom("Arial", size: 20))
                FSButton()
            }.padding(20)
            VStack(alignment: .leading) {
                Text("Velocity: \(velocity, specifier: "%.1f") m/s")
                    .font(.custom("Arial", size: 20))
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
