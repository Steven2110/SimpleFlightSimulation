//
//  FSComponent.swift
//  SimpleFlightSimulation
//
//  Created by Steven Wijaya on 16.02.2023.
//

import SwiftUI

struct FSTimestepButton: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("x5")
                        .frame(width: 100)
                }
                Button {
                    
                } label: {
                    Text("x10")
                        .frame(width: 100)
                }
            }
            HStack {
                Button {
                    
                } label: {
                    Text("÷5")
                        .frame(width: 100)
                }
                Button {
                    
                } label: {
                    Text("÷10")
                        .frame(width: 100)
                }
            }
        }
    }
}

struct FSButton: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("+0.5")
                        .frame(width: 75)
                }
                Button {
                    
                } label: {
                    Text("+1")
                        .frame(width: 75)
                }
                Button {
                    
                } label: {
                    Text("+5")
                        .frame(width: 75)
                }
                Button {
                    
                } label: {
                    Text("+10")
                        .frame(width: 75)
                }
            }
            HStack {
                Button {
                    
                } label: {
                    Text("-0.5")
                        .frame(width: 75)
                }
                Button {
                    
                } label: {
                    Text("-1")
                        .frame(width: 75)
                }
                Button {
                    
                } label: {
                    Text("-5")
                        .frame(width: 75)
                }
                Button {
                    
                } label: {
                    Text("-10")
                        .frame(width: 75)
                }
            }
        }
    }
}
