//
//  ContentView.swift
//  Bookworm
//
//  Created by RAJ RAVAL on 22/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import CoreData

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.managedObjectContext) var moc
    
    @State private var rememberMe = false
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
//        if sizeClass == .compact {
//            return AnyView(VStack {
//                Text("Active Size Class:")
//                Text("COMPACT")
//            }
//            .font(.largeTitle))
//        } else {
//            return AnyView(HStack {
//                Text("Active Size Class:")
//                Text("REGULAR")
//            }
//            .font(.largeTitle))
//        }
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Joe", "Monica", "Luna", "Betty"]
                let lastNames = ["Jones", "Stewart", "Hutchson", "Petty", "David"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
