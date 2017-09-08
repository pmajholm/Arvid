//
//  Plane.swift
//  Arvid
//
//  Created by Pär Majholm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation
import ARKit

class Plane: SCNNode {
    
    var plane: SCNNode
    
    override init() {
        let geo = SCNPlane(width: 3, height: 2)
        plane = SCNNode(geometry: geo)
        plane.eulerAngles = SCNVector3(-Double.pi/2, 0, 0)
        super.init()
        
        self.addChildNode(plane)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
