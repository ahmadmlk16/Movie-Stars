//
//  ScrollActors.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

import SwiftUI
import WebKit
 
struct ScrollActors : View {

    @State private var selectedActor = actorStructList[0]
  
    var body: some View {
        NavigationView{
        ZStack {
            // Color the background to light gray
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
        VStack {
            Text("Movie Stars List")
                .font(.headline)
                .padding(.top)
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(actorStructList, id: \.id) { aActor in
                  
                        Button(action: {
                            self.selectedActor = aActor
                        }) {
                            VStack {
                                
                                getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(getMovieStarData(id: aActor.id).photoFileName)" )
                                    .resizable()
                                      .resizable()
                                    .frame(width: 70, height: 70)
                                Text(aActor.name.replacingOccurrences(of: " ", with: "\n"))
                                    .fixedSize()
                                    .foregroundColor(aActor.name == self.selectedActor.name ? .red : .blue)
                                    .multilineTextAlignment(.center)
                            }
                        }.buttonStyle(PlainButtonStyle())
                        // End of Button
                      
                    }   // End of ForEach
                  
                }   // End of HStack
                // Set font and size for the whole HStack content
                .font(.system(size: 14))
              
            }   // End of ScrollView
            // ScrollView must know its width to be able to scroll horizontally
            .frame(width: UIScreen.main.bounds.width - 20)
            // Fixes ScrollView at its ideal size. Button names do not truncate.
            .fixedSize()
           
            Divider()
            
            ActorDetails(actor: self.selectedActor, queryStringEntered: self.selectedActor.birthdate)
          
        }   // End of VStack
        
            }   // End of ZStack
         .navigationBarHidden(true)
        }
   
    }
}
