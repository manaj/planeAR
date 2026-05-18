import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelName: String
    @ObservedObject var cameraManager: ARCameraManager

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        cameraManager.setup(arView: arView)
        cameraManager.placeModel(named: modelName)

        let pinch = UIPinchGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handlePinch(_:))
        )
        arView.addGestureRecognizer(pinch)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(cameraManager: cameraManager)
    }

    class Coordinator: NSObject {
        var cameraManager: ARCameraManager
        var currentScale: Float = 0.01

        init(cameraManager: ARCameraManager) {
            self.cameraManager = cameraManager
        }

        @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
            if sender.state == .changed {
                let newScale = currentScale * Float(sender.scale)
                cameraManager.updateZoom(newScale)
                currentScale = newScale
                sender.scale = 1
            }
        }
    }
}
