import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer : UIViewRepresentable {
    @Binding var modelName: String
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
        return arView
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // 1.
        //let anchorEntity = AnchorEntity(plane: .any)
        let anchorEntity = AnchorEntity(world: [0, -1, -20])

        // 2.
        guard let modelEntity = try? Entity.loadModel(named: modelName) else { return }
        
        modelEntity.setScale(SIMD3<Float>(0.8, 0.8, 0.8), relativeTo: nil)
        // 3.
        anchorEntity.addChild(modelEntity)
        
        // 4.
        uiView.scene.addAnchor(anchorEntity)
    }
}
