//
//  GameEngine.swift
//  Arvid
//
//  Created by Felix Hedlund on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation

protocol GameEngineDelegate{
    func sendCreep(creep: Creep)
    func gameDidPause()
    func gameDidResume()
}

protocol GameEnginePointsDelegate{
    func goldValueUpdated(gold: Int)
    func pointsValueUpdated(points: Int)
    func gameDidStart()
    func gameEngineDidPause()
}

class GameEngine{
    var creepTimer: Timer?
    var isPlaying = false
    var hasStartedFirstGame = false
    var points = 0{
        didSet{
            self.pointsDelegate?.pointsValueUpdated(points: points)
        }
    }
    var gold = 0{
        didSet{
            self.pointsDelegate?.goldValueUpdated(gold: gold)
        }
    }
    var delegate: GameEngineDelegate?
    var pointsDelegate: GameEnginePointsDelegate?
    
    static let sharedInstance = GameEngine()
    
    func startGame(){
        self.hasStartedFirstGame = true
        gold = 200
        points = 0
        startEngine()
        self.pointsDelegate?.gameDidStart()
    }
    
    func startEngine(){
        self.delegate?.gameDidResume()
        self.isPlaying = true
        creepTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.delegate?.sendCreep(creep: Creep(level: 1))
        })
    }
    
    func pauseEngine(){
        self.delegate?.gameDidPause()
        self.isPlaying = false
        if let c = creepTimer{
            c.invalidate()
        }
        self.pointsDelegate?.gameEngineDidPause()
    }
    
    func buyTower(level: Int) -> Tower?{
        let cost = Tower.getCost(level: level)
        if cost <= self.gold{
            self.gold -= cost
            return Tower(level: level)
        }
        return nil
    }
    
    func creepDied(creep: Creep){
        self.gold += creep.value
        self.points += creep.value * 2
    }
    
}
