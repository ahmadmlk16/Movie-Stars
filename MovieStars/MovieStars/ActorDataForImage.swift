//
//  ActorDataForImage.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI
func getMovieStarData(id: Int) -> Actor {
    
     let myTMDbApiKey = "63b12df97bd2fdb9af3c015f7e427279"
    
    let headers = [
        "x-api-key": "\(myTMDbApiKey)",
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "api.themoviedb.org"
    ]
    
    var foundName = String()
    var foundPhotoFileName = String()
    var foundBirthdate = String()
    var foundBiography = String()
    var foundBirthplace = String()
    var foundImdb_id = String()
    
    let url = "http://api.themoviedb.org/3/person/\(String(id))?api_key=\(myTMDbApiKey)&language=en-US"
   
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    guard error == nil else {
        semaphore.signal()
        return
    }
 
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        semaphore.signal()
        return
    }
    guard let jsonDataFromApi = data else {
        semaphore.signal()
        return
    }
        
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                        options: JSONSerialization.ReadingOptions.mutableContainers)
        var actorJsonObject = [String: Any]()
        if let actor = jsonResponse as? [String: Any] {
            actorJsonObject = actor
        }
        else {
            return
        }
        
        if let name = actorJsonObject["name"] as? String {
            foundName = name
        }
        else {
            return
        }
        
        if let picture = actorJsonObject["profile_path"] as? String {
            foundPhotoFileName = String(picture.dropFirst(1))
        }
        else {
            return
        }
        
        if let birthdate = actorJsonObject["birthday"] as? String {
            foundBirthdate = birthdate
        }
        else {
            return
        }
        
        if let biography = actorJsonObject["biography"] as? String {
            foundBiography = biography.replacingOccurrences(of: "\"", with: "")
        }
        else {
            return
        }
        
        if let birthplace = actorJsonObject["place_of_birth"] as? String {
            foundBirthplace = birthplace
        }
        else {
            return
        }
        
        if let imdbId = actorJsonObject["imdb_id"] as? String {
            foundImdb_id = imdbId
        }
        else {
            return
        }
    } catch {
        
           semaphore.signal()
           return
        }
        semaphore.signal()
    }).resume()
    _ = semaphore.wait(timeout: .now() + 10)
    
    return Actor(id: id, name: foundName, photoFileName: foundPhotoFileName, birthdate: foundBirthdate, biography: foundBiography, birthplace: foundBirthplace, imdb_id: foundImdb_id)
}
