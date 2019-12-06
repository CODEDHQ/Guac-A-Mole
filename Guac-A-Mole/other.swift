//
//  other.swift
//  Guac-A-Mole
//
//  Created by Forat Bahrani on 12/6/19.
//  Copyright © 2019 Forat Bahrani. All rights reserved.
//

import Foundation
extension Array {
    public func random() -> Element {
        return self[randomInt(range: 0...self.count - 1)]
    }
}

public func randomInt(range: ClosedRange<Int>) -> Int {
    return Int(randomFloat(range: Float(range.lowerBound)...Float(range.upperBound)) + 0.5)
}

public func randomFloat(min minValue: Float = 0, max maxValue: Float = 1) -> Float {
    return randomFloat(range: minValue...maxValue)
}

public func randomFloat(range: ClosedRange<Float>) -> Float {
    return Float(range.upperBound - range.lowerBound) * abs(Float.random()) + Float(range.lowerBound)
}

/// This extesion adds some useful functions to Float.
public extension Float {
    /// Gets the individual numbers, and puts them into an array. All negative numbers will start with 0.
    var array: [Int] {
        return description.map { Int(String($0)) ?? 0 }
    }
    
    /// Creates a random Float number.
    ///
    /// - Returns: Returns the created a random Float number.
    static func random() -> Float {
        return Float(Double.random())
    }
}

/// This extesion adds some useful functions to Double.
public extension Double {
    /// Gets the individual numbers, and puts them into an array. All negative numbers will start with 0.
    var array: [Int] {
        return description.map { Int(String($0)) ?? 0 }
    }
    
    /// Creates a random Double number.
    ///
    /// - Returns: Returns the created a random Double number.
    static func random() -> Double {
        return Double(Int.random()) / Double(Int.max)
    }
}

/// This extension adds some useful function to Numeric.
public extension Numeric {
    /// Creates a random integer number.
    ///
    /// - Returns: Returns the creates a random integer number.
    static func random() -> Self {
        let numbers = Randomizer.get(count: MemoryLayout<Self>.size)
        return numbers.withUnsafeBufferPointer { bufferPointer in
            return bufferPointer.baseAddress!.withMemoryRebound(to: Self.self, capacity: 1) {
                return $0.pointee
            }
        }
    }
}


/// Produces great cryptographically random numbers.
private struct Randomizer {
    #if os(Linux)
        /// /dev/urandom file reader.
        static let file = fopen("/dev/urandom", "r")!
    #endif
    /// Random queue.
    static let queue = DispatchQueue(label: "random")
    
    #if os(Linux)
        /// Get a random number of a given capacity.
        ///
        /// - Parameter count: Byte count.
        /// - Returns: Return the random number.
        static func get(count: Int) -> [Int8] {
            let capacity = count + 1
            var data = UnsafeMutablePointer<Int8>.allocate(capacity: capacity)
            defer {
                data.deallocate(capacity: capacity)
            }
            _ = queue.sync {
                fgets(data, Int32(capacity), file)
            }
    
            return Array(UnsafeMutableBufferPointer(start: data, count: count))
        }
    #else
        /// Get a random number of a given capacity.
        ///
        /// - Parameter count: Byte count.
        /// - Returns: Return the random number.
        static func get(count: Int) -> [UInt8] {
            let capacity = count + 1
            var data = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
            var secure: Int32 = 0
            defer {
                data.deallocate()
            }
            _ = queue.sync {
                secure = SecRandomCopyBytes(kSecRandomDefault, capacity, data)
            }
            
            return secure == 0 ? Array(UnsafeMutableBufferPointer(start: data, count: count)) : [0]
        }
    #endif
}
