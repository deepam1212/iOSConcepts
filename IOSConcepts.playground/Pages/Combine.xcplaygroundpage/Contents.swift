// MARK: - Everything Related to Combine Framework

/*
 // MARK: - Introduction
 
 1. Combine is Introduced in iOS 13
 2. Combine is Apple’s declarative Swift framework
    - Imperative way: You tell step-by-step instructions — boil water, add tea, wait, pour.
    - Declarative way: You say "Give me a cup of tea", and the system handles all the steps.
 
    // MARK: - Imperative Style
    label.text = ""
    if userInput.count > 3 {
        label.text = "Valid input"
    }

    // MARK: - Declerative Style
    Text(userInput.count > 3 ? "Valid input" : "")
 
3. Combine Framework is used for handling asynchronous events by combining event-processing operators. Primerily used for things like:
 
    - Responding to UI changes (like text input)
    - Network calls
    - Timer events
    - Bindings between data models and views (especially in SwiftUI)

 🔧 Core Concepts of Combine
 
 1. Publisher
 
    - A type that emits a sequence of values over time.
      let publisher = Just("Hello")
    // This will emit "Hello" and then complete.
 
 2. Subscriber

    - A type that receives values from a publisher.
 
    let subscriber = Subscribers.Sink<String, Never>(
        receiveCompletion: { completion in
            print("Completed: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )

    publisher.subscribe(subscriber)

 3. Operators

    - Functions that transform, combine, filter or otherwise manipulate the values emitted by publishers.

 4. Subjects
 
    - Both a Publisher and a Subscriber. You can manually send values.

 5. Cancellable
 
    - When you subscribe to a publisher, you get a Cancellable object. You use it to cancel the subscription.

 */





