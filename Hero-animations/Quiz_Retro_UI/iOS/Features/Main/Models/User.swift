//
//  User.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 15/05/25.
//

import SwiftUI

enum CurrentLevel {
    case bronze
    case silver
    case gold
}

struct User {
    let name: String
    let username: String
    var earnedXP: Int
    var currentProgress: CGFloat
    
    var streaksCount: Int
    var pointsEarned: Int
    
    var levelProgress: CGFloat
}
