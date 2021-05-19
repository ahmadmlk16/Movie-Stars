//
//  ActorItem.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct ActorItem: View {
    // Input Parameter
    let actor: Actor
   
    var body: some View {
        HStack {
            getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(getMovieStarData(id: actor.id).photoFileName)" )
                .resizable()
                .frame(width: 70, height: 105)
            VStack(alignment: .leading){
                Text(actor.name)
                Text(getDate(stringDate: actor.birthdate))
                Text(actor.birthplace)
            }
        }
            .font(.system(size: 14))   // End of HStack
    }

}
 
 
