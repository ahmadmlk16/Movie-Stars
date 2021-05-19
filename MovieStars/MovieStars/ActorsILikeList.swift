//
//  ActorsILikeList.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct ActorsILikeList: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        NavigationView {
            List {
                // Each movie struct has its own unique 'id' used by ForEach
                ForEach(userData.actorsList) { aActor in
                    NavigationLink(destination: ActorDetails(actor: aActor, queryStringEntered: aActor.birthdate)) {
                        ActorItem(actor: aActor)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
            .navigationBarTitle(Text("Movie Stars I Like"), displayMode: .inline)
           
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
           
        }   // End of NavigationView
    }
   
    /*
     -------------------------------
     MARK: - Delete Selected movie
     -------------------------------
     */
    /*
     IndexSet:  A collection of unique integer values that represent the indexes of elements in another collection.
     first:     The first integer in self, or nil if self is empty.
     */
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            userData.actorsList.remove(at: first)
        }
        // Set the global variable point to the changed list
        actorStructList = userData.actorsList
    }
   
    /*
     -----------------------------
     MARK: - Move Selected movie
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
 
        userData.actorsList.move(fromOffsets: source, toOffset: destination)
       
        // Set the global variable point to the changed list
        actorStructList = userData.actorsList
    }
}
 
 

