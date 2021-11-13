//
//  ContentView.swift
//  Stepper
//
//  Created by sarim khan on 13/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var postViewModel:PostViewModel = PostViewModel()
    
    var body: some View {
        
        NavigationView {
            
            
            if(postViewModel.postState==PostViewModelState.Loading){
                ProgressView()
            } else if(postViewModel.postState==PostViewModelState.Loaded){
                List(postViewModel.posts){  posts in
                    Text(posts.title)
                }
                .navigationTitle("Posts")
            }else if(postViewModel.postState==PostViewModelState.Error){
                Text("Error")
            }else{
                EmptyView()
            }
            
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
    }
}
