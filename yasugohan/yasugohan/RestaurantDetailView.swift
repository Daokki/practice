//
//  RestaurantDetailView.swift
//  yasugohan
//
//  Created by D A on 2024/08/31.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack {
            Text(restaurant.name)
                .font(.largeTitle)
                .padding()
            
            Text("価格: \(restaurant.price)")
                .font(.title)
                .padding()
            
            Text("評価: \(restaurant.rating) / 5")
                .font(.title2)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(restaurant.name), displayMode: .inline)
    }
}

