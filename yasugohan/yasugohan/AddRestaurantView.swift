//
//  AddRestaurantView.swift
//  yasugohan
//
//  Created by D A on 2024/08/31.
//

// AddRestaurantView.swift
import SwiftUI
import PhotosUI

struct AddRestaurantView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var restaurants: [Restaurant]
    
    @State private var name = ""
    @State private var price = ""
    @State private var rating = 3
    @State private var selectedImageData: Data? = nil
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("店名")) {
                    TextField("例: 松屋", text: $name)
                }
                Section(header: Text("値段")) {
                    TextField("例: ¥500", text: $price)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("評価")) {
                    Picker("評価", selection: $rating) {
                        ForEach(1..<6) { rating in
                            Text("星\(rating)").tag(rating)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("写真")) {
                    if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Text("写真を選択")
                        }
                    }
                }
            }
            .navigationBarTitle("新しい飲食店を追加")
            .navigationBarItems(leading: Button("キャンセル") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("追加") {
                let newRestaurant = Restaurant(name: name, price: price, rating: rating, imageData: selectedImageData)
                restaurants.append(newRestaurant)
                saveRestaurants()
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showingImagePicker) {
                PhotoPicker(imageData: $selectedImageData)
            }
        }
    }
    
    private func saveRestaurants() {
        if let data = try? JSONEncoder().encode(restaurants) {
            UserDefaults.standard.set(data, forKey: "restaurants")
        }
    }
}

