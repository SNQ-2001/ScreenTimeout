//
//  ContentView.swift
//  Demo
//
//  Created by 宮本大新 on 2022/11/24.
//

import SwiftUI
import ScreenTimeout

struct ContentView: View {
    @State var status: ScreenStates = .active
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10, id: \.self) { index in
                    Text(status == .active ? "Password: \(index * Int.random(in: 100..<200))" : "\(Image(systemName: "lock.fill")) locked")
                }
            }
        }
        .onTimeout(seconds: 5) { status in
            withAnimation {
                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
