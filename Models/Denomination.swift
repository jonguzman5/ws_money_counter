import Foundation

/// Represents a monetary denomination with its value and count
@Observable
public class Denomination {
    /// The monetary value of this denomination
    public let value: Decimal
    
    /// The current count of this denomination
    public var count: Int
    
    /// Creates a new denomination with the given value
    public init(value: Decimal, count: Int = 0) {
        self.value = value
        self.count = count
    }
    
    /// Returns the total value of this denomination (value * count)
    public var totalValue: Decimal {
        value * Decimal(count)
    }
}
