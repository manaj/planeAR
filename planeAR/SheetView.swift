import SwiftUI

struct SheetView: View {
    @Binding var isPresented: Bool
    @State var modelName: String = "hummingbird"
    @StateObject var cameraManager = ARCameraManager()

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ARViewContainer(modelName: $modelName, cameraManager: cameraManager)
                .ignoresSafeArea(edges: .all)
                .scaleEffect(4.0)

            Button() {
                isPresented.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(24)
        }
    }
}
