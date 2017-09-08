//
//  Tower.swift
//  Arvid
//
//  Created by Pär Majholm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation
import SceneKit

class TowerNode : SCNNode {
    
    override init() {
        super.init()
        
        let baseGeo = SCNBox(width: 0.12, height: 0.12, length: 0.12, chamferRadius: 0)
        let bodyGeo = SCNBox(width: 0.1, height: 0.5, length: 0.1, chamferRadius: 0)
        let topGeo = SCNBox(width: 0.15, height: 0.15, length: 0.15, chamferRadius: 0)
        
        let base = SCNNode(geometry: baseGeo)
        let body = SCNNode(geometry: bodyGeo)
        let top = SCNNode(geometry: topGeo)
        
        body.position = SCNVector3Make(0, 0.25, 0)
        top.position = SCNVector3Make(0, 0.5, 0)
        
        self.addChildNode(base)
        self.addChildNode(body)
        self.addChildNode(top)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        
        topGeo.materials = [material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
