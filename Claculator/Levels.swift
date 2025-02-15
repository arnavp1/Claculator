import SwiftUI

struct Level {
    let buttonMapping: [CalcButton: CalcButton]
    let targetNumber: Int
}

// Global levels array – bindings are cumulative and can be overridden.
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
    ),

    // Level 7
    Level(
        buttonMapping: [
            .two: .one,
            .three: .add
        ],
        targetNumber: 120
    ),

    // Level 8
    Level(
        buttonMapping: [
            .four: .subtract,
            .seven: .mutliply
        ],
        targetNumber: 250
    ),

    // Level 9
    Level(
        buttonMapping: [
            .zero: .divide,
            .eight: .subtract
        ],
        targetNumber: 360
    ),

    // Level 10
    Level(
        buttonMapping: [
            .one: .mutliply,
            .five: .add
        ],
        targetNumber: 480
    ),

    // Level 11
    Level(
        buttonMapping: [
            .six: .divide,
            .nine: .add
        ],
        targetNumber: 600
    ),

    // Level 12
    Level(
        buttonMapping: [
            .two: .subtract,
            .three: .divide,
            .four: .add
        ],
        targetNumber: 720
    ),

    // Level 13
    Level(
        buttonMapping: [
            .seven: .zero,
            .eight: .mutliply,
            .nine: .subtract
        ],
        targetNumber: 840
    ),

    // Level 14
    Level(
        buttonMapping: [
            .one: .add,
            .six: .mutliply,
            .zero: .divide
        ],
        targetNumber: 960
    ),

    // Level 15
    Level(
        buttonMapping: [
            .five: .subtract,
            .three: .add,
            .eight: .divide
        ],
        targetNumber: 1080
    ),

    // Level 16
    Level(
        buttonMapping: [
            .two: .mutliply,
            .seven: .add,
            .four: .subtract
        ],
        targetNumber: 1260
    ),

    // Level 17
    Level(
        buttonMapping: [
            .one: .divide,
            .nine: .mutliply,
            .three: .subtract
        ],
        targetNumber: 1440
    ),

    // Level 18
    Level(
        buttonMapping: [
            .five: .add,
            .eight: .subtract,
            .zero: .mutliply
        ],
        targetNumber: 1620
    ),

    // Level 19
    Level(
        buttonMapping: [
            .two: .divide,
            .four: .add,
            .six: .subtract
        ],
        targetNumber: 1800
    ),

    // Level 20
    Level(
        buttonMapping: [
            .one: .subtract,
            .three: .divide,
            .seven: .mutliply,
            .nine: .add
        ],
        targetNumber: 2000
    )
]
