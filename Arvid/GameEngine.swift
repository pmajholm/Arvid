//
//  GameEngine.swift
//  Arvid
//
//  Created by Felix Hedlund on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation

protocol GameEngineDelegate{
    func gameDidStart()
    func sendCreep(creep: Creep)
    func gameEngineDidPause()
    func goldValueUpdated(gold: Int)
    func pointsValueUpdated(points: Int)
}

class GameEngine{
    var creepTimer: Timer?
    var points = 0{
        didSet{
            self.delegate?.pointsValueUpdated(points: points)
        }
    }
    var gold = 0{
        didSet{
            self.delegate?.goldValueUpdated(gold: gold)
        }
    }
    var delegate: GameEngineDelegate?
    
    static let sharedInstance = GameEngine()
    
    func startGame(){
        gold = 200
        points = 0
        startEngine()
    }
    
    func startEngine(){
        creepTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.delegate?.sendCreep(creep: Creep(level: 1))
        })
    }
    
    func pauseEngine(){
        if let c = creepTimer{
            c.invalidate()
        }
        self.delegate?.gameEngineDidPause()
    }
    
    func buyTower(level: Int) -> Tower?{
        let cost = Tower.getCost(level: level)
        if cost <= self.gold{
            self.gold -= cost
            return Tower2(level: level)
        }
        return nil
    }
    
    func creepDied(creep: Creep){
        self.gold += creep.value
        self.points += creep.value * 2
    }
    
}
