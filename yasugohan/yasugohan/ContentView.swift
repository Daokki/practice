//
//  ContentView.swift
//  yasugohan
//
//  Created by D A on 2024/08/31.
//

// ContentView.swift
// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var restaurants: [Restaurant] = []
    @State private var showingModal = false
    
    var body: some View {
        NavigationView {
            List(restaurants) { restaurant in
                NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                    HStack {
                        if let imageData = restaurant.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        VStack(alignment: .leading) {
                            Text(restaurant.name)
                                .font(.headline)
                            Text(restaurant.price)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("⭐️ \(restaurant.rating)")
                    }
                }
            }
            .navigationBarTitle("安ごはんナビ")
            .navigationBarItems(trailing:
                                    Button(action: {
                showingModal = true
            }) {
                Text("投稿する")
            }
                .sheet(isPresented: $showingModal) {
                    AddRestaurantView(restaurants: $restaurants)
                }
            )
        }
        .onAppear {
            loadRestaurants()
        }
    }
    
    private func loadRestaurants() {
        if let data = UserDefaults.standard.data(forKey: "restaurants") {
            if let decoded = try? JSONDecoder().decode([Restaurant].self, from: data) {
                restaurants = decoded
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

