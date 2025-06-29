// MARK: - Everything Closures
/*
 
 // MARK: - 🔹 What is a Closure?
 A closure is a self-contained block of functionality that can be passed around and used in your code.
 
 🔹 Closure Syntax in Swift

 { (parameters) -> returnType in
    // code
 }
 
 Example:
 */
 let greeting = { (name: String) -> String in
     return "Hello \(name)"
 }

print(greeting("Deepam"))
/*
 // MARK: - 🔹 Types of Closures
 1. Global functions – have a name and don’t capture any values.

 2. Nested functions – have a name and can capture values from their enclosing function.

 3. Closure expressions – unnamed closures written using lightweight syntax, can capture values.
 
 // MARK: - 🔹 Trailing Closure Syntax
 If the closure is the last argument, you can use trailing closure syntax.

 Example:
 */
func perform(action: () -> Void) {
    action()
}

perform {
    print("Action Performed")
}
/*
 // MARK: - 🔹 Simplifying Closure Syntax
 Swift allows type inference, shorthand argument names, and implicit return for single expressions.
 */
// Full Syntax
let sum = {(a: Int, b: Int) -> Int in
    return a + b
}
// Simplified with Inferred Types
let sum1: (Int, Int) -> Int = { a, b in
    return a + b
}
// Using Shorthand Argument Names
let sum2: (Int, Int) -> Int = {
    return $0 + $1
}
// Even Shorter with Implicit Return
let sum3: (Int, Int) -> Int = { $0 + $1 }
/*
 🔹 Closures Capturing Values (Capturing Context)
 Closures capture and store references to variables and constants from the context in which they are defined.
 
 Example:
 */
func makeIncrementer(by amount: Int) -> () -> Int {
    var total = 0
    return {
        total += amount
        return total
    }
}

let incrementBy2 = makeIncrementer(by: 2)
print(incrementBy2()) // 2
print(incrementBy2()) // 4
print(incrementBy2()) // 6
/*
 🔹 Closures Are Reference Types
 Even if you assign a closure to multiple variables, they all refer to the same captured context.
 */
