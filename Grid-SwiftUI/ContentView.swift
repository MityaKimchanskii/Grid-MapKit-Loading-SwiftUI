//
//  ContentView.swift
//  Grid-SwiftUI
//
//  Created by Mitya Kim on 7/26/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // MARK: Slider for Grid
    @State private var sliderValue: CGFloat = 2
    
    // MARK: Loading
    @State private var downloaded: CGFloat = 0
    
    // MARK: MapKit
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.734560, longitude: -95.393690), latitudinalMeters: 500, longitudinalMeters: 500)
    
    // MARK: - Loading
    private func startDownload() {
        let timer = Timer(timeInterval: 0.1, repeats: true) { timer in
            if self.downloaded < 100 {
                self.downloaded += 1
            } else {
                timer.invalidate()
            }
        }
        
        RunLoop.main.add(timer, forMode: .common)
    }
    
    // MARK: Grid
    let animals = ["🐶", "🐹", "🐛", "🦀", "🐒", "🐅", "🐕", "🐇", "🐈", "🐓", "🐆", "🐖"]
    
    var body: some View {
        
        Map(coordinateRegion: $region)
        
        // MARK: Grid
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: Int(self.sliderValue))
        
        // MARK: Grid
        VStack {
            
            Slider(value: $sliderValue, in: 2...10, step: 1)
            Text(String(format: "%.0f", self.sliderValue))
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.animals, id: \.self) { animal in
                        Text(animal)
                            .font(.system(size: 50))
                    }
                }
            }
            
            // MARK: Loading
            VStack {
                VStack {
                    ProgressView("Loading", value: self.downloaded, total: 100)
                    
                    Button("Download") {
                        self.startDownload()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
