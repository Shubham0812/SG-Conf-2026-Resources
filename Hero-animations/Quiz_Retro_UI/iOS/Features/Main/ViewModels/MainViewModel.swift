//
//  MainViewModel.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

@Observable
class MainViewModel {
    var profileOpened = false
    
    var user: User = .init(name: "User", username: "shubham_iosdev", earnedXP: 400, currentProgress: 0.45, streaksCount: 2, pointsEarned: 800, levelProgress: 2)
    
    var friends: [Friend] = [
        Friend(name: "alex", color: .red),
        Friend(name: "matthe", color: .yellow),
        Friend(name: "alicia", color: .blue),
        Friend(name: "bosco", color: .orange),
        Friend(name: "patchy", color: .indigo),
        Friend(name: "sindi", color: .teal),
    ]
    
    var hintUsed = false    
    var quizModeOpened = false
}
