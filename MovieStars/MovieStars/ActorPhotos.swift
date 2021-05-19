//
//  ActorPhotos.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

struct ActorPhotos: View {
    
      @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack{
            VStack{
                Text("Movie Stars")
                    .foregroundColor(.blue)
                getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(getMovieStarData(id: userData.slideShowActor!.id).photoFileName)" )
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 575)
                Text(userData.slideShowActor!.name)
                    .foregroundColor(.blue)
                
            }
            
            .onAppear() {
                self.userData.startTimer()
            }
            .onDisappear() {
                self.userData.stopTimer()
            }
            
        }
    }
}

struct ActorPhotos_Previews: PreviewProvider {
    static var previews: some View {
        ActorPhotos()
    }
}
