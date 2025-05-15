import SwiftUI

/// Main view for counting money
struct MainCountView: View {
    @StateObject private var viewModel = CountViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Total display
                Text("$\(String(format: "%.2f", Double(truncating: NSDecimalNumber(decimal: viewModel.total))))")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.accentColor)
                
                // Denominations grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),
                          spacing: 16) {
                    ForEach(0..<viewModel.denominations.count, id: \.self) { index in
                        DenominationView(
                            denomination: viewModel.denominations[index],
                            onIncrement: { viewModel.incrementDenomination(at: index) },
                            onDecrement: { viewModel.decrementDenomination(at: index) }
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Money Counter")
            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        viewModel.clearAll()
                    }) {
                        Text("Clear")
                    }
                    
                    Button(action: {
                        // TODO: Implement sharing functionality
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            )
            .overlay(
                Group {
                    if viewModel.showToast {
                        VStack {
                            Text("All denominations cleared")
                                .padding()
                                .background(Color.black.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                viewModel.showToast = false
                            }
                        }
                    }
                }
            )
        }
    }
}

/// Reusable view for individual denomination
struct DenominationView: View {
    let denomination: Denomination
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    var body: some View {
        VStack {
            // Value display
            Text("$\(String(format: "%.2f", Double(truncating: NSDecimalNumber(decimal: denomination.value))))")
                .font(.headline)
            
            // Quantity display
            Text("\(denomination.count)")
                .font(.title)
                .fontWeight(.bold)
            
            // Increment/Decrement buttons
            HStack {
                Button(action: onDecrement) {
                    Image(systemName: "minus.circle")
                        .font(.title2)
                }
                
                Button(action: onIncrement) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
