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
        let anchorEntity = AnchorEntity(world: [0, -1, -1])

        guard let modelEntity = try? Entity.loadModel(named: modelName) else { return }

        modelEntity.setScale(SIMD3<Float>(0.01, 0.01, 0.01), relativeTo: nil)

        modelEntity.availableAnimations.forEach { animation in
            modelEntity.playAnimation(animation.repeat())
        }

        anchorEntity.addChild(modelEntity)
        uiView.scene.addAnchor(anchorEntity)
    }
}
