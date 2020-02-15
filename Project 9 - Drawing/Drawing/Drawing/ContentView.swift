//
//  ContentView.swift
//  Drawing
//
//  Created by RAJ RAVAL on 12/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arrow: Shape {
    
    var thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangle = Triangle()
        let rectangle = Rectangle()
        
        path.addPath(triangle.path(in: CGRect(x: 0, y: 0, width: thickness, height: rect.height / 2)))
        path.addPath(rectangle.path(in: CGRect(x: rect.width / 2 - rect.width / 4, y: rect.height / 2, width: thickness / 2, height: rect.height / 3)))
        
        return path
    }
}

struct InvertedTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: -rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: -rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: -rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: -rect.minY))
        
        return path
    }
}

struct ColorCyclingRect : View {
    
    var steps = 300
    var amount = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                .inset(by: CGFloat(value))
                .strokeBorder(LinearGradient(gradient: Gradient(colors:
                    [self.color(for: value, brightness: 1),
                    self.color(for: value, brightness: 2)]),
                                             startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)),
                              lineWidth: 5)
            }
        }
    .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    
    @State private var thickness: CGFloat = 100
    @State private var borderWidth: CGFloat = 10
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            
            ZStack {
                ColorCyclingRect(amount: self.colorCycle)
            }
            
            Arrow(thickness: thickness)
                .stroke(Color.yellow, style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
                .frame(width: thickness, height: 300)
            
            Text("Arrow Width")
            Slider(value: $thickness, in: 20...300)
                .padding()
            
            Text("Border Width")
            Slider(value: $borderWidth, in: 1...30)
                .padding()
            
            Text("Color")
            Slider(value: $colorCycle)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
