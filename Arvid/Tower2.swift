//
//  Tower.swift
//  Arvid
//
//  Created by Felix Hedlund on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation

class Tower2{
    var level: Int!
    var attackPoints: Int!
    var cost: Int!
    
    init(level: Int){
        self.level = level
        self.attackPoints = level * 2
        self.cost = level * 3
    }
    
    static func getCost(level: Int) -> Int{
        return level * 3
    }
}
