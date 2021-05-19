//
//  Actor.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation


struct Actor: Hashable, Codable, Identifiable {
   
    var id: Int        // Storage Type: String, Use Type (format): UUID
    var name: String
    var photoFileName : String
    var birthdate : String
    var biography: String
    var birthplace: String
    var imdb_id : String
}
 


