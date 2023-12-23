//
//  DashboardView.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 15/09/2022.
//

import SwiftUI
import Charts

struct BarChart: View {
    
    
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart {
                ForEach(Array([10,24,20,32].enumerated()), id: \.offset) { index, value in
                    BarMark(
                        x: .value("Shape Type", index),
                        y: .value("Total Count", value)
                    ).foregroundStyle(by: .value("Shape Color", "Purple"))
                }
            }.chartForegroundStyleScale([ "Purple": .purple])
        } else {
            // Fallback on earlier versions
            Text("Please update your device to iOS 16 or later to be able to use this feature")
        }
    }
}

struct UIDashboardView: View {
    var body: some View {
        VStack {
            List {
                BarChart()
                    .frame(height: 100)
                    .padding()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        UIDashboardView()
    }
}
