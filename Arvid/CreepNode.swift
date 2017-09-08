//
//  Monster.swift
//  Arvid
//
//  Created by Tobias Timm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation
import ARKit

class CreepNode: SCNNode, Updatable {
 
    override init() {
        super.init()
        
        let sphereGeometry = SCNSphere(radius: radius())
        let sphere = SCNNode(geometry: sphereGeometry)
        let collission = SCNPhysicsBody(type: .dynamic, shape: nil)
        let sphereMaterial = SCNMaterial()
        sphere.categoryBitMask = 1
        sphere.physicsBody = collission
        sphere.physicsBody?.isAffectedByGravity = false
        sphereMaterial.diffuse.contents = UIColor.green
        
        sphereGeometry.materials = [sphereMaterial]
        
        self.addChildNode(sphere)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func radius() -> CGFloat {
        return 0.15
    }
    
    func update(time: TimeInterval) {
        self.position = SCNVector3(self.position.x + 0.01, self.position.y, self.position.z)
    }
}
