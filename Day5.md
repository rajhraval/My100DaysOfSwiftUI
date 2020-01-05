## Day 5 - HackingWithSwift - 100DaysOfSwiftUI Challenge

> Dennis Ritchie (the creator of the C programming language) encouraged modularity by telling all and sundry that function calls were really, really cheap in C. Everybody started writing small functions and modularizing. Years later we found out that function calls were still expensive, and our code was often spending 50% of its time just calling them. Dennis had lied to us! But it was too late; we were all hooked... - Steve Johnson

### Functions

Today I learnt about:

- Writing functions
- Accepting parameters
- Returning values
- Parameter labels
- Omitting parameter labels
- Default parameters
- Variadic functions
- Writing and running throwing functions
- inout parameters

The summary of the entire day was:

- Functions let us re-use code without repeating ourselves.
- Functions can accept parameters – just tell Swift the type of each parameter.
- Functions can return values, and again you just specify what type will be sent back. Use tuples if you want to return several things.
- You can use different names for parameters externally and internally, or omit the external name entirely.
- Parameters can have default values, which helps you write less code when specific values are common.
- Variadic functions accept zero or more of a specific parameter, and Swift converts the input to an array.
- Functions can throw errors, but you must call them using ```try``` and handle errors using ```catch```.
- You can use ```inout``` to change variables inside a function, but it’s usually better to return a new value.

**That's all for the Day 5 of 100DaysOfSwiftUI!**

