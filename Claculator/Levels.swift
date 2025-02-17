struct Level {
    let buttonMapping: [CalcButton: CalcButton]
    let targetNumber: Int
}

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
            .three: .five
        ],
        targetNumber: 120
    ),

    // Level 8
    Level(
        buttonMapping: [
            .four: .two,
            .seven: .three
        ],
        targetNumber: 250
    ),

    // Level 9
    Level(
        buttonMapping: [
            .zero: .five,
            .eight: .nine
        ],
        targetNumber: 360
    ),

    // Level 10
    Level(
        buttonMapping: [
            .one: .seven,
            .five: .three
        ],
        targetNumber: 480
    ),

    // Level 11
    Level(
        buttonMapping: [
            .six: .eight,
            .nine: .two
        ],
        targetNumber: 600
    ),

    // Level 12
    Level(
        buttonMapping: [
            .two: .four,
            .three: .one,
            .four: .seven
        ],
        targetNumber: 720
    ),

    // Level 13
    Level(
        buttonMapping: [
            .seven: .zero,
            .eight: .two,
            .nine: .three
        ],
        targetNumber: 840
    ),

    // Level 14
    Level(
        buttonMapping: [
            .one: .nine,
            .six: .four,
            .zero: .eight
        ],
        targetNumber: 960
    ),

    // Level 15
    Level(
        buttonMapping: [
            .five: .one,
            .three: .two,
            .eight: .six
        ],
        targetNumber: 1080
    ),

    // Level 16
    Level(
        buttonMapping: [
            .two: .seven,
            .seven: .zero,
            .four: .three
        ],
        targetNumber: 1260
    ),

    // Level 17
    Level(
        buttonMapping: [
            .one: .five,
            .nine: .six,
            .three: .eight
        ],
        targetNumber: 1440
    ),

    // Level 18
    Level(
        buttonMapping: [
            .five: .two,
            .eight: .four,
            .zero: .three
        ],
        targetNumber: 1620
    ),

    // Level 19
    Level(
        buttonMapping: [
            .two: .nine,
            .four: .five,
            .six: .seven
        ],
        targetNumber: 1800
    ),

    // Level 20
    Level(
        buttonMapping: [
            .one: .eight,
            .three: .nine,
            .seven: .four,
            .nine: .two
        ],
        targetNumber: 2000
    )
]
