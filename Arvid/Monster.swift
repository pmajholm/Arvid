//
//  Monster.swift
//  Arvid
//
//  Created by Tobias Timm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation
import ARKit

class Monster: SCNNode {
 
    override init() {
        super.init()
        
        let sphereGeometry = SCNSphere(radius: 0.15)
        let sphere = SCNNode(geometry: sphereGeometry)
        
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.green
        
        sphereGeometry.materials = [sphereMaterial]
        
        self.addChildNode(sphere)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
