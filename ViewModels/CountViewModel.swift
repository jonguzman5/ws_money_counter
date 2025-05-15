import Foundation
import SwiftUI

/// Manages the state and logic for the money counting functionality
class CountViewModel: ObservableObject {
    /// All available denominations
    @Published var denominations: [Denomination]
    
    /// The total value of all denominations
    @Published var total: Decimal = 0
    
    /// Whether to show the toast for undoing clear operation
    var showToast: Bool = false
    
    /// Initializes the view model with standard denominations
    init() {
        // Initialize with standard US denominations
        self.denominations = [
            Denomination(value: 100), // $100 bill
            Denomination(value: 50),  // $50 bill
            Denomination(value: 20),  // $20 bill
            Denomination(value: 10),  // $10 bill
            Denomination(value: 5),   // $5 bill
            Denomination(value: 1),   // $1 bill
            Denomination(value: 0.25), // Quarter
            Denomination(value: 0.10), // Dime
            Denomination(value: 0.05), // Nickel
            Denomination(value: 0.01)  // Penny
        ]
        
        updateTotal()
    }
    
    /// Updates the total value based on current denominations
    private func updateTotal() {
        total = denominations.reduce(0) { $0 + $1.totalValue }
    }
    
    /// Increments the count of a denomination
    func incrementDenomination(at index: Int) {
        guard index < denominations.count else { return }
        
        denominations[index].count += 1
        updateTotal()
    }
    
    /// Decrements the count of a denomination
    func decrementDenomination(at index: Int) {
        guard index < denominations.count else { return }
        
        if denominations[index].count > 0 {
            denominations[index].count -= 1
            updateTotal()
        }
    }
    
    /// Clears all denominations
    func clearAll() {
        for denomination in denominations {
            denomination.count = 0
        }
        updateTotal()
        showToast = true
    }
}
