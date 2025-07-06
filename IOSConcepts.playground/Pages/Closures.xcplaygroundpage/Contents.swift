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
 - If the closure is the last argument, you can use trailing closure syntax.
 - Trailing closures improve readability when the closure is the last parameter.

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
 
 
 🔹 Escaping vs Non-Escaping Closures
 Non-Escaping (Default):
 Executed within the function's scope.

 Can be passed like a normal parameter.
 */
func doSomething(action: () -> Void) {
    action()
}
/*
 Escaping (@escaping):
 Used when a closure outlives the function, like in async operations.
 */
var storedClosure: (() -> Void)?

@MainActor func storeClosure(_ closure: @escaping () -> Void) {
    storedClosure = closure
}
/*
 🔹 Auto Closures
 Automatically wraps an expression in a closure.
 */
func log(_ message: @autoclosure () -> String) {
    print("Log: \(message())")
}
log("This is a log message.")  // Automatically converted to closure

// MARK: - Most Important Interview Questions

// MARK: - Question Can you write a function that returns a closure capturing variables from the outer scope?
func performClosures(_ lastName: String) -> () -> String {
    var firstName: String = "Deepam"
    return {
        return firstName + lastName
    }
}

// MARK: - Question Explain autoclosures. When and why would you use them?

// An @autoclouser automatically wraps expression in a closure. useful for delaying execution
// Without @autoclosures
func printResult(_ result: () -> Bool) {
    print("Result is : \(result())")
}
printResult {
    2 > 1
}
// With @autoclosures
func printResultwithAuto(_ result: @autoclosure () -> Bool) {
    print("Result is: \(result())")
}
printResultwithAuto(2 > 1)
// As there is no need to ass { } with @autoclosures present
/*
 🧠 Why is this useful?
 
 1. Improves readability when the caller passes simple expressions.
 2. Makes APIs look like regular expressions, even though they're lazily evaluated under the hood.
 
 Without @autoclosures it looks ugly and verbose
 */
func assert(_ condition: @autoclosure () -> Bool, message: String) {
    if condition() {
        print(message)
    }
}
assert(2 > 1, message: "2 is greater than 1")
// MARK: - Question What are capturing lists in closures and how are [weak self] vs [unowned self] different?

/*
 [weak self] – makes self optional (self?)
 [unowned self] – assumes self will exist as long as closure exists; unsafe if self deallocates.
 */
// MARK: - Can closures be equatable in Swift? How would you compare them?
/*
 No, closures are not equatable in Swift. You can’t compare them directly:

 If needed, wrap logic in structs and make them Equatable.
 */
let a = { print("Hi") }
let b = { print("Hi") }

//print(a == b)  ❌ Error: closures are not Equatable
// MARK: - Question What is @Sendable in Swift?

/*
 @Sendable is a closure annotation that tells the Swift compiler:

 "This closure is safe to be sent across threads and used concurrently."

 It enforces thread-safety rules — so your closure:

 - Cannot capture non-thread-safe data (like reference types that aren’t safe to mutate across threads).

 - Cannot mutate captured values unless they are thread-safe (like immutable let values or actors).
 
 💡 Why does Swift need @Sendable?

 With structured concurrency (introduced in Swift 5.5+), closures often get passed to background threads or detached tasks:

 Task.detached {
     // This runs on a background thread
     print("Doing background work")
 }

 To guarantee safety, Swift checks that such closures:

 - Don’t access mutable shared state.
 - Don’t capture reference types unsafely.

 This is where @Sendable comes in.

 let name = "Deepam"

 let closure: @Sendable () -> Void = {
     print("Hello, \(name)") // ✅ Capturing immutable data is allowed
 }
 ✅ This is fine because name is a let constant.


 var counter = 0

 let closure: @Sendable () -> Void = {
     counter += 1 // ❌ Error: Cannot capture mutable var in @Sendable closure
 }

Example: Bank account fetching amount, as we are fetching data and at the same time we are deducting amount
 */
class BankAccount {
    let accountName: String = ""
    var amount: Int = 0
    var counter: Int = 0
    
    let closures: @Sendable () -> Void = {
        print(counter)
    }
    
    func fetchDetails(_ completion: @escaping @Sendable ((_ name: String, _ amount: Int) -> Void)) {
        completion(accountName, amount)
    }
    
    func doSomething() {
        fetchDetails { name, amount in
            print(name)
            print(amount)
        }
    }
}
// Note: @Sendable closures are not applies to @nonescaping closures only to @escaping closures as @nonescaping closures are not passed in multi threaded enviroment so it makes no sense
