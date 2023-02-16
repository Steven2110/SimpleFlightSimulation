//
//  FSComponent.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import SwiftUI

struct FSTimestepButton: View {
    
    @Binding var timestep: Double
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    timestep = timestep * 5
                } label: {
                    Text("x5")
                        .frame(width: 100)
                }
                Button {
                    timestep = timestep * 10
                } label: {
                    Text("x10")
                        .frame(width: 100)
                }
            }
            HStack {
                Button {
                    timestep = timestep / 5
                } label: {
                    Text("÷5")
                        .frame(width: 100)
                }
                Button {
                    timestep = timestep / 10
                } label: {
                    Text("÷10")
                        .frame(width: 100)
                }
            }
        }
    }
}

struct FSButton: View {
    
    @Binding var value: Double
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    value = value + 0.5
                } label: {
                    Text("+0.5")
                        .frame(width: 75)
                }
                Button {
                    value = value + 1
                } label: {
                    Text("+1")
                        .frame(width: 75)
                }
                Button {
                    value = value + 5
                } label: {
                    Text("+5")
                        .frame(width: 75)
                }
                Button {
                    value = value + 10
                } label: {
                    Text("+10")
                        .frame(width: 75)
                }
            }
            HStack {
                Button {
                    value = value - 0.5
                } label: {
                    Text("-0.5")
                        .frame(width: 75)
                }
                Button {
                    value = value - 1
                } label: {
                    Text("-1")
                        .frame(width: 75)
                }
                Button {
                    value = value - 5
                } label: {
                    Text("-5")
                        .frame(width: 75)
                }
                Button {
                    value = value - 10
                } label: {
                    Text("-10")
                        .frame(width: 75)
                }
            }
        }
    }
}
