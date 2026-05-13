import SwiftUI

struct SheetView: View {
    @Binding var isPresented : Bool
    @State var modelName : String = "hummingbird"
    
    var body: some View {
        // 1.
        ZStack(alignment: .topTrailing) {

            ARViewContainer(modelName: $modelName)
                .ignoresSafeArea(edges: .all)

        
           
        }
    }
}

#Preview {
    SheetView(isPresented: .constant(true))
}
