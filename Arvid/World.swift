//
//  Plane.swift
//  Arvid
//
//  Created by Pär Majholm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import Foundation
import ARKit

class World: SCNNode, GameEngineDelegate {
    
    var plane: SCNNode
    
    let planeLength: Float = 3
    
    let planeWidth: Float = 1.5
    
    let selectionWidth: Float = 0.5
    
    var selection: [SCNNode] = []
    
    var towers: [SCNNode] = []
    
    // add monsters to this array so that towers can find them
    var creeps: [CreepNode] = []
    
    var updatables: [Updatable] = []
    
    override init() {
        let geo = SCNPlane(width: 3, height: 1.5)
        plane = SCNNode(geometry: geo)
        geo.firstMaterial?.transparency = 0.2
        plane.eulerAngles = SCNVector3(-Double.pi/2, 0, 0)
        super.init()
        
        self.addChildNode(plane)
        addSelections()
        
        GameEngine.sharedInstance.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertSelectionArea(position: SCNVector3) {
        let geo = SCNPlane(width: 0.4, height: 0.4)
        let selectionNode = SCNNode(geometry: geo)
        plane.addChildNode(selectionNode)
        selectionNode.position = position
    }
    
    func addSelections() {
        for i in 0...9 {
            var offsetX = Float(i) * 0.5
            var positionZ: Float = -(planeWidth/2) + (0.5/2)
            if i > 5  {
                offsetX = Float(i - 5) * 0.5
                 positionZ = (planeWidth/2) - (0.5/2)
            }

            let positionX = planeLength/2 - (offsetX) - 0.5
            
            let geo = SCNPlane(width: 0.4, height: 0.4)
            let node = SCNNode(geometry: geo)
            geo.firstMaterial?.diffuse.contents = UIColor.gray
            self.addChildNode(node)
            node.position = SCNVector3(positionX, 0.1, positionZ)
            node.eulerAngles = SCNVector3(-Double.pi/2, 0, 0)
            node.name = "selection_\(i)"
            selection.append(node)
        }
    }
    
    func getPositionFrom(name: String) -> SCNVector3? {
        let filtered = selection.filter {
            $0.name == name
        }
        if filtered.count > 0 {
            return filtered[0].position
        }
        return nil
    }
    
    func addTower(selectionName: String) {
        let tower = TowerNode(world: self)
        tower.position = getPositionFrom(name: selectionName)!
        self.updatables.append(tower)
        plane.addChildNode(tower)
    }
    
    func spawnCreep() {
        let creepNode = CreepNode()
        creepNode.position = SCNVector3(-planeWidth, Float(creepNode.radius()) / 2, 0) //TODO: set position
        creepNode.name = "something" //TODO: set name
        creeps.append(creepNode)
        plane.addChildNode(creepNode)
    }
    
    //MARK: Game Engine Delegate
    
    func sendCreep(creep: Creep) {
        //Create and send creep on plane
        print("Sending creep of level: \(String(creep.level))")
        self.spawnCreep()
    }
    
    func gameDidPause() {
        //Pause all nodes in their actions
    }
    
    func gameDidResume() {
        //Resume all nodes in their actions
    }

}

extension UIViewController: SCNPhysicsContactDelegate {
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
    }
}

