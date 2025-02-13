import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.darkGray)
        default:
            return Color(UIColor(
                red: 42/255.0,
                green: 42/255.0,
                blue: 44/255.0,
                alpha: 1
            ))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ClaculatorView: View {
    
    // ------------------------------
    // State for arithmetic
    // ------------------------------
    @State private var value = "0"
    @State private var runningNumber: Double = 0.0
    @State private var currentOperation: Operation = .none
    
    // ------------------------------
    // Show the typed expression
    // ------------------------------
    @State private var expression = "0"
    
    // ------------------------------
    // Multi-level logic
    // ------------------------------
    @State private var currentLevelIndex: Int = 0
    @State private var showLevelComplete: Bool = false
    @State private var movesCount: Int = 0
    @State private var levelHighScores: [Int: Int] = [:]
    @State private var showLevelSelector: Bool = false
    
    @State private var highestUnlockedLevel: Int = 0
    
    // Levels
    let levels = gameLevels
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    // ------------------------------
    // MARK: - Body
    // ------------------------------
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // New Level Info positioned at the top:
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Level \(currentLevelIndex + 1)")
                                .foregroundColor(.white)
                                .font(.title3)
                            Text("Target: \(levels[currentLevelIndex].targetNumber)")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Moves: \(movesCount)")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            if let highScore = levelHighScores[currentLevelIndex] {
                                Text("Best: \(highScore) moves")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            } else {
                                Text("Best: --")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding()
                    
                    // Expression Display
                    HStack {
                        Spacer()
                        Text(expression)
                            .bold()
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .padding()
                    
                    // Calculator Buttons
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    didTap(button: item)
                                }) {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: buttonWidth(item: item),
                                            height: buttonHeight()
                                        )
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(buttonWidth(item: item) / 2)
                                }
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
                .alert(isPresented: $showLevelComplete) {
                    Alert(
                        title: Text("Level Complete!"),
                        message: Text("You reached the target in \(movesCount) moves."),
                        dismissButton: .default(Text("Next Level")) {
                            nextLevel()
                        }
                    )
                }
            }
            // No toolbar items (Reset / Select removed)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { }
            // The sheet for level selection
            .sheet(isPresented: $showLevelSelector) {
                VStack {
                    Text("Select a Level")
                        .font(.headline)
                        .padding()
                    
                    List(0..<levels.count, id: \.self) { idx in
                        let isLocked = idx > highestUnlockedLevel
                        
                        Button("Level \(idx + 1)") {
                            if !isLocked {
                                currentLevelIndex = idx
                                showLevelSelector = false
                                resetCalculatorState()
                            }
                        }
                        .disabled(isLocked)
                        .foregroundColor(isLocked ? .gray : .blue)
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
    
    // ------------------------------
    // MARK: - Tap Handler
    // ------------------------------
    func didTap(button: CalcButton) {
        movesCount += 1
        
        // Figure out the real (mapped) button behind the scenes
        let mapping = fullMapping(upTo: currentLevelIndex)
        let realButton = mapping[button] ?? button
        
        // If there's already an operation active, don't allow a second one
        if [.add, .subtract, .mutliply, .divide].contains(realButton),
           currentOperation != .none {
            return
        }
        
        switch realButton {
            
        case .decimal:
            // Show the pressed decimal on the display, but logic uses 'realButton'
            if !value.contains(".") {
                // Display the button the user physically pressed
                updateExpression(with: button)
                value += "."
            }
            
        case .add, .subtract, .mutliply, .divide:
            // Show the pressed operation on the display
            updateExpression(with: button)
            handleOperationButton(realButton)
            
        case .equal:
            // Show '=' pressed (or ignore in expression) and do logic
            // If you want '=' to appear in expression, do updateExpression(with: button) here
            handleOperationButton(realButton)
            
        case .clear:
            // AC resets everything
            resetCalculatorState()
            
        case .percent:
            // Show the level selector
            showLevelSelector = true
            
        case .negative:
            // Not implemented
            break
            
        default:
            // It's a digit. Display the pressed digit, but store the mapped value
            updateExpression(with: button)
            if value == "0" {
                value = realButton.rawValue
            } else {
                value += realButton.rawValue
            }
        }
    }
    
    // ------------------------------
    // MARK: - Expression Display
    // ------------------------------
    private func updateExpression(with displayedButton: CalcButton) {
        // This function always uses the physically pressed button (not mapped).
        switch displayedButton {
        case .add, .subtract, .mutliply, .divide:
            if expression == "0" {
                expression = displayedButton.rawValue
            } else {
                expression += displayedButton.rawValue
            }
        case .equal:
            // If you want '=' to show, add it here.
            break
        case .clear:
            expression = "0"
        case .decimal:
            if !expression.contains(".") {
                if expression == "0" {
                    expression = "0."
                } else {
                    expression += "."
                }
            }
        default:
            // Digits
            if expression == "0" {
                expression = displayedButton.rawValue
            } else {
                expression += displayedButton.rawValue
            }
        }
    }
    
    // ------------------------------
    // MARK: - Operation Logic
    // ------------------------------
    private func handleOperationButton(_ button: CalcButton) {
        switch button {
        case .add:
            currentOperation = .add
            runningNumber = Double(value) ?? 0.0
            value = "0"
        case .subtract:
            currentOperation = .subtract
            runningNumber = Double(value) ?? 0.0
            value = "0"
        case .mutliply:
            currentOperation = .multiply
            runningNumber = Double(value) ?? 0.0
            value = "0"
        case .divide:
            currentOperation = .divide
            runningNumber = Double(value) ?? 0.0
            value = "0"
        case .equal:
            let lhs = runningNumber
            let rhs = Double(value) ?? 0.0
            var result: Double = 0.0
            
            switch currentOperation {
            case .add:
                result = lhs + rhs
            case .subtract:
                result = lhs - rhs
            case .multiply:
                result = lhs * rhs
            case .divide:
                if rhs == 0 {
                    value = "Error"
                    expression = "Error"
                    currentOperation = .none
                    return
                } else {
                    result = lhs / rhs
                }
            case .none:
                result = Double(value) ?? 0.0
            }
            
            // Format: if it's whole, remove ".0"
            let resultString: String
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                resultString = String(format: "%.0f", result)
            } else {
                resultString = String(result)
            }
            
            expression = resultString
            value = resultString
            checkIfLevelComplete()
            currentOperation = .none
            
        default:
            break
        }
    }
    
    // ------------------------------
    // MARK: - Mappings & Levels
    // ------------------------------
    private func fullMapping(upTo levelIndex: Int) -> [CalcButton: CalcButton] {
        var cumulative: [CalcButton: CalcButton] = [:]
        for i in 0...levelIndex {
            for (key, value) in levels[i].buttonMapping {
                cumulative[key] = value
            }
        }
        return cumulative
    }
    
    private func checkIfLevelComplete() {
        let target = levels[currentLevelIndex].targetNumber
        if let result = Double(value), abs(result - Double(target)) < 0.000001 {
            let bestSoFar = levelHighScores[currentLevelIndex] ?? Int.max
            if movesCount < bestSoFar {
                levelHighScores[currentLevelIndex] = movesCount
            }
            
            if currentLevelIndex < levels.count - 1 {
                highestUnlockedLevel = max(highestUnlockedLevel, currentLevelIndex + 1)
            }
            
            showLevelComplete = true
        }
    }
    
    private func nextLevel() {
        showLevelComplete = false
        if currentLevelIndex < levels.count - 1 {
            currentLevelIndex += 1
            resetCalculatorState()
        } else {
            currentLevelIndex = 0
            resetCalculatorState()
        }
    }
    
    private func resetCalculatorState() {
        value = "0"
        runningNumber = 0.0
        currentOperation = .none
        movesCount = 0
        expression = "0"
    }
    
    // ------------------------------
    // MARK: - Button Sizes
    // ------------------------------
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}
