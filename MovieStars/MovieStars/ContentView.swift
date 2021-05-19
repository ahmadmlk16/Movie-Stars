//
//  ContentView.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct ContentView: View {
 
    var body: some View {
 
        TabView {
            ActorPhotos()
                .tabItem {
                    Image(systemName: "rectangle.stack.person.crop")
                    Text("Actor Photos")
                }
            ActorsILikeList()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Actors I Like")
                }
            SearchActor()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search Actor")
                }
            ScrollActors()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("Scroll Actors")
                }
        }   // End of TabView
        .font(.headline)
        .imageScale(.medium)
        .font(Font.title.weight(.regular))
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
