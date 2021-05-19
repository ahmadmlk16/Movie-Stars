//
//  ActorsFoundList.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI


struct ActorsFoundList: View {
      @EnvironmentObject var userData: UserData
    var body: some View {

            List {
                // Each movie struct has its own unique 'id' used by ForEach
                ForEach(searchActorsList) { aActor in
                    NavigationLink(destination:
                    ActorsFoundDetails(actor: aActor, queryStringEntered: aActor.birthdate)) {
                        ActorItem(actor: aActor)
                    }
                }
            }   // End of List
                .navigationBarTitle(Text("Found Actors"), displayMode: .inline)

    }
}

struct ActorsFoundList_Previews: PreviewProvider {
    static var previews: some View {
        ActorsFoundList()
    }
}
