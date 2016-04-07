//
//  Bar.swift
//  Appartoo
//
//  Created by zh ch on 07/04/16.
//  Copyright (c) 2016 Chong. All rights reserved.
//

import Foundation

class Bar{
    
    //from json
    var id: Int?
    
    var address: String?
    
    var name: String?
    
    var url: String?
    
    var image_url: String?
    
    var tags: String = ""
    
    var latitude: Double?
    
    var longitude: Double?
    
    //constructor
    init(json: NSDictionary) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        if let address = json["address"] as? String {
            self.address = address
        }
        if let name  = json["name"] as? String {
            self.name = name
        }
        if let url  = json["url"] as? String {
            self.url = url
        }
        if let image_url  = json["image_url"] as? String {
            self.image_url = image_url
        }
        if let tags  = json["tags"] as? String {
            self.tags = tags
        }
        if let latitude  = json["latitude"] as? Double {
            self.latitude = latitude
        }
        if let longitude  = json["longitude"] as? Double {
            self.longitude = longitude
        }
    }
    
}