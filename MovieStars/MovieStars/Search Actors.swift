//
//  Search Actors.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation


// Global array of Star structs
var searchActorsList = [Actor]()


/*
 -----------------------------------------------------
 MARK: - Get Stars Data from API for the Given Query
 -----------------------------------------------------
 */
public func searchActors(apiQueryUrl: String) {
    
    // Clear out previous content in the global array
    searchActorsList = [Actor]()
    
    
    
        let jsonDataFromApi = getJsonDataFromApi(apiUrl:
            "http://api.themoviedb.org/3/search/person?api_key=63b12df97bd2fdb9af3c015f7e427279&language=en-US&query=\(apiQueryUrl)&page=1&include_adult=false")
            

        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
                  /*
                   Foundation framework’s JSONSerialization class is used to convert JSON data
                   into Swift data types such as Dictionary, Array, String, Number, or Bool.
                   */
                  let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                                      options: JSONSerialization.ReadingOptions.mutableContainers)
                  
                  //------------------------------------------
                  // Obtain Top Level JSON Object (Dictionary)
                  //------------------------------------------
                  var topLevelDictionary = Dictionary<String, Any>()
                  
                  if let jsonObject = jsonResponse as? [String: Any] {
                      topLevelDictionary = jsonObject
                  } else {

                      return
                  }
                  
                  //------------------------------------
                  // Obtain Array of "hits" JSON Objects
                  //------------------------------------

                  var arrayOfHitsJsonObjects = Array<Any>()
                  
                  if let jsonArray = topLevelDictionary["results"] as? [Any] {
                      arrayOfHitsJsonObjects = jsonArray
                  } else {

                      return
                      
                      
                  }
                  for index in 0..<arrayOfHitsJsonObjects.count {
                      
                      //-------------------------
                      // Obtain Star Dictionary
                      //-------------------------
                      var movieDictionary = Dictionary<String, Any>()
                      
                      if let jsonDictionary = arrayOfHitsJsonObjects[index] as? [String: Any] {
                          
                          movieDictionary = jsonDictionary
                          }
                     else {

                          return
                      }
                      
                      //----------------
                      // Initializations
                      //----------------
                      
                      var id = 0, profile_path = "", name = "", birthday = ""
                    var biography = "", placeOfBirth = "" , imdbID = ""

                      
                      //-------------------
                      // Obtain Star Name
                      //-------------------
                      
                      /*
                       IF starDictionary["label"] has a value AND the value is of type String THEN
                       unwrap the value and assign it to local variable starName
                       ELSE leave starName as set to ""
                       */
                      if let i = movieDictionary["id"] as? Int {
                          id = i
                      }

                    
                    
                    
                    if let p = movieDictionary["profile_path"] as? String
                    {
                        profile_path = p
                    }

                    
                      if let n = movieDictionary["name"] as! String? {
                          name = n
                      }
                    
                      
                    if (id == 0 || profile_path.count == 0 || name.count == 0){
                        break
                    }
                      
                      let jsonDataFromApi = getJsonDataFromApi(apiUrl:
                        "http://api.themoviedb.org/3/person/\(id)?api_key=63b12df97bd2fdb9af3c015f7e427279")
                      
                      
                      
                      do {
                                /*
                                 Foundation framework’s JSONSerialization class is used to convert JSON data
                                 into Swift data types such as Dictionary, Array, String, Number, or Bool.
                                 */
                                let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                                                    options: JSONSerialization.ReadingOptions.mutableContainers)
                                
                                //------------------------------------------
                                // Obtain Top Level JSON Object (Dictionary)
                                //------------------------------------------
                                var topLevelDictionary = Dictionary<String, Any>()
                                
                                if let jsonObject = jsonResponse as? [String: Any] {
                                    topLevelDictionary = jsonObject
                                } else {
                            
                                    // foundStarsList will be empty
                                    return
                                }
                          

                          
                                  if let b = topLevelDictionary["birthday"] as? String {
                                      birthday = b
                                  }else
                                  {
                                    birthday = ""
                        }
                          
                                  if let B = topLevelDictionary["biography"] as! String? {
                                      biography = B
                                  }
                        
                        
                        if let p = topLevelDictionary["place_of_birth"] as? String? {
                            placeOfBirth = p ?? ""
                        }
                        
                        if let I = topLevelDictionary["imdb_id"] as! String? {
                            imdbID = I
                        }

                                //------------------------------------
                                // Obtain Array of "hits" JSON Objects
                                //------------------------------------
                             
                      } catch {

                                       return
                                   }
                      
                      
                      
                      
                      

        
                      //*************************************************************
                      // Construct a New Star Struct and Add it to foundStarsList
                      //*************************************************************
                      
                    let foundActor = Actor(id: id, name: name, photoFileName: profile_path, birthdate: birthday, biography: biography, birthplace: placeOfBirth, imdb_id: imdbID)
                      
                      searchActorsList.append(foundActor)
                      
                  }   // End of the for loop
                  
              } catch {

                  return
              }

          }
    



