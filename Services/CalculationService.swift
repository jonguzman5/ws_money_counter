import Foundation

/// Handles the calculation of total money value
struct CalculationService {
    /// Calculates the total value from a list of denominations
    func computeTotal(from denominations: [Denomination]) -> Decimal {
        denominations.reduce(0) { $0 + $1.totalValue }
    }
}
