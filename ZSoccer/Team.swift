//
//  Team.swift
//  ZSoccer
//
//  Created by Matěj Žemlička on 22.03.2022.
//

import Foundation
import UIKit

class Team {
    
    public let name: String
    public let country: String
    public let logoTeam: String
    
    init(name: String, country: String, logoTeam: String) {
        self.name = name
        self.logoTeam = logoTeam
        self.country = country
    }

    
    
}

