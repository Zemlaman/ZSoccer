//
//  Match.swift
//  ZSoccer
//
//  Created by Matěj Žemlička on 22.03.2022.
//

import Foundation
import UIKit

class Match {
    
    public let name1: String
    public let logo1: UIImage
    public let name2: String
    public let logo2: UIImage
    public let score1: Int
    public let score2: Int
    
    init(name1: String, logo1: UIImage, name2: String, logo2: UIImage, score1: Int, score2: Int) {
        self.name1 = name1
        self.logo1 = logo1
        self.name2 = name2
        self.logo2 = logo2
        self.score1 = score1
        self.score2 = score2
    }
    
    
}
