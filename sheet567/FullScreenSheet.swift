import SwiftUI

struct FullScreenSheet: View {
    @State private var isPresented = false

    var body: some View {
        Button("cool") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                Text("'Legal Entity' shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, 'control' means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity.").font(.title.bold())
                    .foregroundStyle(.white)
                    .presentationBackground(.blue)
                    .fullScreenSheet()
            }
    }
}

struct FullScreenSheetView: UIViewControllerRepresentable {
    @Binding private var hack: Void
    init() { _hack = .constant(()) }

    func makeUIViewController(context _: Context) -> UIViewController { .init() }
    func updateUIViewController(_ controller: UIViewController, context _: Context) {
        controller.parent?.presentationController?.setValue(true, forKey: "wantsFullScreen")
    }
}

extension View {
    func fullScreenSheet() -> some View {
        overlay(FullScreenSheetView())
    }
}

#Preview {
    FullScreenSheet()
}
