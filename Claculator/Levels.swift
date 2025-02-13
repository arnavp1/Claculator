import SwiftUI

// Level model remains the same
struct Level {
    let buttonMapping: [CalcButton: CalcButton]
    let targetNumber: Int
}

// Global levels array
let gameLevels: [Level] = [
    // Level 1
    Level(
        buttonMapping: [
            .one: .nine,
            .divide: .add
        ],
        targetNumber: 18
    ),
    
    // Level 2
    Level(
        buttonMapping: [
            .one: .three,
            .two: .five,
            .subtract: .mutliply
        ],
        targetNumber: 45
    ),
    
    // Level 3
    Level(
        buttonMapping: [
            .nine: .one,
            .mutliply: .divide,
            .add: .subtract
        ],
        targetNumber: 2
    ),
    
    // Level 4
    Level(
        buttonMapping: [
            .zero: .eight,
            .three: .seven,
            .five: .two
        ],
        targetNumber: 100
    ),
    
    // Level 5
    Level(
        buttonMapping: [
            .seven: .zero,
            .eight: .one,
            .nine: .two,
            .four: .five,
            .divide: .subtract
        ],
        targetNumber: 99
    ),
    
    // Level 6
    Level(
        buttonMapping: [
            .six: .four,
            .add: .divide
        ],
        targetNumber: 8
    )
]
