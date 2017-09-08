//
//  Creep.swift
//  Arvid
//
//  Created by Felix Hedlund on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation

protocol CreepDelegate{
    func creepDied()
}

class Creep{
    var level: Int!
    var lifePoints: Int!
    var value: Int!
    var delegate: CreepDelegate?
    
    init(level: Int){
        self.level = level
        self.lifePoints = level * 2
        self.value = level * 3
    }
    
    func creepGotHitByTower(attackPoints: Int){
        self.lifePoints = lifePoints - attackPoints
        if lifePoints <= 0{
            GameEngine.sharedInstance.creepDied(creep: self)
            self.delegate?.creepDied()
        }
    }
    
}
