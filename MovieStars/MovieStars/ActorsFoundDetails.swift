//
//  ActorsFoundDetails.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
import MapKit
 
struct ActorsFoundDetails: View {
    // Input Parameter
    let actor: Actor
    let queryStringEntered : String
    
    @State private var geocoderReturnedResults = false
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
     @EnvironmentObject var userData: UserData
    
     @State private var showAddedMessage = false
   
    var body: some View {
        
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {

                Section(header: Text("Movie Star Name")) {
                    Text(actor.name)
                }
                Section(header: Text("Movie Star Photo")) {
                 getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(getMovieStarData(id: actor.id).photoFileName)" )
                     .resizable()
                        .aspectRatio(contentMode: .fit)
                }

                Section(header: Text("Movie Star Birthdate")) {
                    Text(getDate(stringDate: actor.birthdate))
                }
            
                Section(header: Text("Add this Movie to My Movies list")) {
                                                 Button(action: {
                                                     // Append the country found to userData.countriesList
                                                  self.userData.actorsList.append(self.actor)
                              
                                                     // Set the global variable point to the changed list
                                                  actorStructList = self.userData.actorsList
                                       
                                                    
                                                     self.showAddedMessage = true
                                                 }) {
                                                     Image(systemName: "plus")
                                                         .imageScale(.medium)
                                                         .font(Font.title.weight(.regular))
                                                 }
                                             }
            
                Section(header: Text("Movie Star Birthplace")) {
                    Text(actor.birthplace)
                }
               Section(header: Text("Show Birthplace on Map")) {
                    askGeocoder
                    if geocoderReturnedResults {
                        NavigationLink(destination: showLocationOnMap) {
                            Text("Show")
                                .font(.headline)
                        }
                    }
                }
                Section(header: Text("Movie Star Biography")) {
                    Text(actor.biography)
                }
            
                Section(header: Text("Show IMDb Website")) {
                    NavigationLink(destination: WebView(url: "https://www.imdb.com/name/\(actor.imdb_id)")) {
                        Image(systemName: "globe")
                        .resizable()
                        .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                    }
                }

        }   // End of Form
            .navigationBarTitle(Text(actor.name), displayMode: .inline)
            .alert(isPresented: $showAddedMessage, content: { self.alert })
            .font(.system(size: 14))
    }
    
    var alert: Alert {
           Alert(title: Text("Movie Star Added!"),
                 message: Text("Selected movie star is added to your My Movie Stars I Like List."),
                 dismissButton: .default(Text("OK")) )
       }

    var askGeocoder: Text {
             if !geocoderReturnedResults {
                askForwardGeocoder(query: actor.birthplace)
             }
             return Text("\(self.latitude), \(self.longitude)").font(.system(size: 12))
         }
      
         var showLocationOnMap: some View {
            
             // Remove spaces, if any, at the beginning and at the end of the entered search query string
            let queryStringTrimmed = actor.birthplace.trimmingCharacters(in: .whitespacesAndNewlines)
            
             if (queryStringTrimmed.isEmpty) {
                 // Show error message in another view
                 return AnyView(errorMessage)
             }
      
             var mapType: MKMapType
              mapType = MKMapType.standard

            
             return AnyView(
                 MapView(mapType: mapType, latitude: self.latitude, longitude: self.longitude,
                         delta: 8000.0, deltaUnit: "meters", annotationTitle: self.actor.name,
                         annotationSubtitle: "Location")
             )
         }
        
         var errorMessage: some View {
             VStack {
                 Image(systemName: "exclamationmark.triangle")
                     .imageScale(.large)
                     .font(Font.title.weight(.medium))
                     .foregroundColor(.red)
                 Text("The Search Field is Empty. \nPlease enter a search string!")
                     .padding()
                     .multilineTextAlignment(.center)
             }
         }
        
         func askForwardGeocoder(query: String) {
            
             // Instantiate a forward geocoder object
             let forwardGeocoder = CLGeocoder()
            
             /*
              Ask the forward geocoder object to
              (a) execute its geocodeAddressString method in a new thread *** asynchronously ***
              (b) determine the geolocation (latitude, longitude) of the given query, and
              (c) give the results to the completion handler function geocoderCompletionHandler running under the main thread.
              */
             forwardGeocoder.geocodeAddressString(query) { (placemarks, error) in
                 self.geocoderCompletionHandler(withPlacemarks: placemarks, error: error)
             }
            
             /*
              "This method submits the specified location data to the geocoding server asynchronously and returns.
              The completion handler block [i.e., geocoderCompletionHandler() function] will be executed on the main thread.
              After initiating a forward-geocoding request, do not attempt to initiate another forward- or reverse-geocoding request.
              
              Geocoding requests are rate-limited for each app, so making too many requests in a short period of time
              may cause some of the requests to fail. When the maximum rate is exceeded, the geocoder passes an error object
              with the value network to your completion handler." [Apple]
             
              Due to the asynchronous processing nature, statements after this method may not be executed.
              */
         }
        
         /*
          ---------------------------------
          MARK: - Process Geocoding Results
          ---------------------------------
          */
         func geocoderCompletionHandler(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
            
             if let _ = error {
                 // Error occurred: Forward Geocoding Unsuccessful!
                 // Show button will be hidden since geocoderReturnedResults will be false
                 return
             }
            
             var geolocation: CLLocation?
            
             if let placemarks = placemarks, placemarks.count > 0 {
                 geolocation = placemarks.first?.location
             }
            
             if let locationObtained = geolocation {
                 self.latitude = locationObtained.coordinate.latitude
                 self.longitude = locationObtained.coordinate.longitude
                 self.geocoderReturnedResults = true
                
             } else {
                 // Error occurred: Unable to Find a Matching Location!
                 // Show button will be hidden since geocoderReturnedResults will be false
                 return
             }
         }

}
 
