## Day 12 - HackingWithSwift - 100DaysOfSwiftUI Challenge

> I call it(null referenes) a billion dollar mistake - Tony Hoare

### Optionals

Today I learnt about:

- Handling missing data
- Unwrapping optionals with ```if let```
- Unwraping optionals with ```guard let```
- Force unwrapping
- Implicitly unwrapped optionals
- Nil coalescing
- Optional Chaining
- Optional ```try```
- Failable initialisers
- Type casting

The summary of the entire day was:

- Optionals let us represent the absence of a value in a clear and unambiguous way.
- Swift won’t let us use optionals without unwrapping them, either using ```if let``` or using ```guard let```.
- You can force unwrap optionals with an exclamation mark(```!```), but if you try to force unwrap ```nil``` your code will crash.
- Implicitly unwrapped optionals don’t have the safety checks of regular optionals.
- You can use nil coalescing to unwrap an optional and provide a default value if there was nothing inside.
- Optional chaining lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.
- You can use ```try?``` to convert a throwing function into an optional return value, or ```try!``` to crash if an error is thrown.
- If you need your initializer to fail when it’s given bad input, use ```init?()``` to make a failable initializer.
- You can use typecasting to convert one type of object to another.

**That's all for the Day 12 of 100DaysOfSwiftUI!**

