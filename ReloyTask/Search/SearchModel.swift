//
//  SearchModel.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation

struct SearchModel: Codable {
    var hits: [Hit]?
    
    mutating func reset(){
        self = SearchModel()
    }
}

struct Hit: Codable {
    var id: Int?
    var tags: String?
    var previewURL: String?
    var largeImageURL: String?
    var imageWidth, imageHeight, views: Int?
    var userID: Int?
    var user: String?
    var isSelected : Bool?
        
    enum CodingKeys: String, CodingKey {
        case id, tags, previewURL, largeImageURL, imageWidth, imageHeight, views, user
        case userID = "user_id"
    }
}


