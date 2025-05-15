import SwiftUI

/// A reusable toast view modifier
struct ToastModifier: ViewModifier {
    @Binding var isPresenting: Bool
    let duration: TimeInterval
    let onDismiss: () -> Void
    let content: () -> AnyView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresenting {
                VStack {
                    Spacer()
                    self.content()
                        .transition(.slide)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresenting = false
                            onDismiss()
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func toast(
        isPresenting: Binding<Bool>,
        duration: TimeInterval,
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(ToastModifier(
            isPresenting: isPresenting,
            duration: duration,
            onDismiss: onDismiss,
            content: content as! () -> AnyView
        ))
    }
}
