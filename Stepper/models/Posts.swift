//
//  Posts.swift
//  Stepper
//
//  Created by sarim khan on 13/11/2021.
//

import Foundation


enum PostViewModelState {
    case Loading , Error , Loaded , Initial
}

struct Posts : Decodable, Identifiable {
    
    let  userId:Int
    let  id:Int
    let  title:String
    let  body:String
    
}



