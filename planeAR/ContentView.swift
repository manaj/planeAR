import SwiftUI

struct ContentView: View {
        
    @State var isPresented: Bool = false

    var body: some View {
        VStack {
            // 1.
            Text("🐦")
                .font(.system(size: 100))
                .padding(24)
            // 2.
            Button {
                isPresented.toggle()
                    } label: {
                        Label("View in AR", systemImage: "arkit")
                    }.buttonStyle(BorderedProminentButtonStyle())
                .padding(24)


        }
                .padding()
                
        // 3.
        .fullScreenCover(isPresented: $isPresented, content: {
           SheetView(isPresented: $isPresented)
        })
        
    }
}
