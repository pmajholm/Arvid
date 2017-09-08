//
//  SeekingEnergyBall.swift
//  Arvid
//
//  Created by Pär Majholm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation
import ARKit

class SeekingEnergyBall: SCNNode, Updatable {
    
    let target: SCNNode
    let speed = 0.1
    var attackPoint: Int!
    
    init(target: SCNNode, attackPoint: Int) {
        self.target = target
        self.attackPoint = attackPoint
        super.init()
        let geo = SCNSphere(radius: 0.01)
        geometry = geo
     
        // collission
        self.categoryBitMask = 2
        let collission = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.physicsBody = collission
        self.physicsBody?.isAffectedByGravity = false
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        geometry?.materials = [material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(time: TimeInterval) {
        let vector = target.position - position
        let unitVector = vector.normalized()
        self.localTranslate(by: unitVector * Float(time))
    }
}
