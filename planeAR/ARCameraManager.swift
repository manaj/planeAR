//
//  ARCameraManager.swift
//  planeAR
//
//  Created by Manaj on 2026-05-18.
//

import ARKit
import RealityKit
import Combine

class ARCameraManager: NSObject, ObservableObject, ARSessionDelegate {
    @Published var zoomLevel: Float = 0.01
    
    var arView: ARView?
    var placedEntity: Entity?
    
    func setup(arView: ARView) {
        self.arView = arView
        arView.session.delegate = self
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        arView.session.run(config)
    }
    
    func placeModel(named modelName: String) {
        guard let arView = arView else { return }
        
        let anchorEntity = AnchorEntity(world: [0, -1, -1])
        
        guard let modelEntity = try? Entity.loadModel(named: modelName) else {
            print("Could not load model: \(modelName)")
            return
        }
        
        modelEntity.setScale(SIMD3<Float>(0.01, 0.01, 0.01), relativeTo: nil)
        
        modelEntity.availableAnimations.forEach { animation in
            modelEntity.playAnimation(animation.repeat())
        }
        
        anchorEntity.addChild(modelEntity)
        arView.scene.addAnchor(anchorEntity)
        placedEntity = modelEntity
    }
    
    func updateZoom(_ scale: Float) {
        zoomLevel = scale
        placedEntity?.setScale(SIMD3<Float>(scale, scale, scale), relativeTo: nil)
    }
}
