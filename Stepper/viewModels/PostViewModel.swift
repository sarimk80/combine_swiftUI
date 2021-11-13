//
//  PostViewModel.swift
//  Stepper
//
//  Created by sarim khan on 13/11/2021.
//

import Foundation
import Combine  


final class PostViewModel : ObservableObject{
    
    @Published var posts:[Posts] = [Posts]()
    @Published var postState:PostViewModelState = PostViewModelState.Initial
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        getAllposts()
    }
    
    func getAllposts()  {
      guard  let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else {
            self.postState=PostViewModelState.Error
            return
           
        }
        
        self.postState=PostViewModelState.Loading
        
        URLSession.shared.dataTaskPublisher(for: url)
            
            .tryMap{ (data,response) in
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else{
                    print(response)
                    self.postState=PostViewModelState.Error
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Posts].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: { data in
                
                self.posts = data
                self.postState=PostViewModelState.Loaded
                
            })
            .store(in: &cancellable)
        
    }
    
}
