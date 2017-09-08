//
//  ViewController.swift
//  Arvid
//
//  Created by Pär Majholm on 2017-09-08.
//  Copyright © 2017 Mayholm. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        plane.isHidden = true
        scene.rootNode.addChildNode(plane)
        
        scene.rootNode.addChildNode(Tower())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    @IBAction func startPressed(_ sender: Any) {
        
    }
    
//    func translateBasedOnScreenPos(_ pos: CGPoint, instantly: Bool, infinitePlane: Bool) {
//        let result = worldPositionFromScreenPosition(pos, infinitePlane: true)
//
//        moveVirtualObjectToPosition(result.position, instantly, !result.hitAPlane)
//    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        let planeHitTestResults = sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        
        if let result = planeHitTestResults.first {
            plane.isHidden = false
            let transform = result.worldTransform
            plane.position = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        }
    }
    
//    func worldPositionFromScreenPosition(_ position: CGPoint,
//                                         in sceneView: ARSCNView,
//                                         objectPos: float3?,
//                                         infinitePlane: Bool = false) -> (position: float3?, planeAnchor: ARPlaneAnchor?, hitAPlane: Bool) {
//
//        let dragOnInfinitePlanesEnabled = UserDefaults.standard.bool(for: .dragOnInfinitePlanes)
//
//        // -------------------------------------------------------------------------------
//        // 1. Always do a hit test against exisiting plane anchors first.
//        //    (If any such anchors exist & only within their extents.)
//
//        let planeHitTestResults = sceneView.hitTest(position, types: .existingPlaneUsingExtent)
//        if let result = planeHitTestResults.first {
//
//            let planeHitTestPosition = result.worldTransform.translation
//            let planeAnchor = result.anchor
//
//            // Return immediately - this is the best possible outcome.
//            return (planeHitTestPosition, planeAnchor as? ARPlaneAnchor, true)
//        }
//
//        // -------------------------------------------------------------------------------
//        // 2. Collect more information about the environment by hit testing against
//        //    the feature point cloud, but do not return the result yet.
//
//        var featureHitTestPosition: float3?
//        var highQualityFeatureHitTestResult = false
//
//        let highQualityfeatureHitTestResults = sceneView.hitTestWithFeatures(position, coneOpeningAngleInDegrees: 18, minDistance: 0.2, maxDistance: 2.0)
//
//        if !highQualityfeatureHitTestResults.isEmpty {
//            let result = highQualityfeatureHitTestResults[0]
//            featureHitTestPosition = result.position
//            highQualityFeatureHitTestResult = true
//        }
//
//        // -------------------------------------------------------------------------------
//        // 3. If desired or necessary (no good feature hit test result): Hit test
//        //    against an infinite, horizontal plane (ignoring the real world).
//
//        if (infinitePlane && dragOnInfinitePlanesEnabled) || !highQualityFeatureHitTestResult {
//
//            if let pointOnPlane = objectPos {
//                let pointOnInfinitePlane = sceneView.hitTestWithInfiniteHorizontalPlane(position, pointOnPlane)
//                if pointOnInfinitePlane != nil {
//                    return (pointOnInfinitePlane, nil, true)
//                }
//            }
//        }
//
//        // -------------------------------------------------------------------------------
//        // 4. If available, return the result of the hit test against high quality
//        //    features if the hit tests against infinite planes were skipped or no
//        //    infinite plane was hit.
//
//        if highQualityFeatureHitTestResult {
//            return (featureHitTestPosition, nil, false)
//        }
//
//        // -------------------------------------------------------------------------------
//        // 5. As a last resort, perform a second, unfiltered hit test against features.
//        //    If there are no features in the scene, the result returned here will be nil.
//
//        let unfilteredFeatureHitTestResults = sceneView.hitTestWithFeatures(position)
//        if !unfilteredFeatureHitTestResults.isEmpty {
//            let result = unfilteredFeatureHitTestResults[0]
//            return (result.position, nil, false)
//        }
//
//        return (nil, nil, false)
//    }
}
