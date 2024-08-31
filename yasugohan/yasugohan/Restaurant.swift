//
//  Restaurant.swift
//  yasugohan
//
//  Created by D A on 2024/08/31.
//

import Foundation

// 飲食店モデル
struct Restaurant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var price: String
    var rating: Int
    var imageData: Data? // 画像データを保持するプロパティ
}
