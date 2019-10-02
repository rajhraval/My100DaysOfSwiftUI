## Day 10 - HackingWithSwift - 100DaysOfSwiftUI Challenge

> Any fool can write code that a computer can understand, but good programmers write code that humans can understand. - Martin Fowler

### Classes

Today I learnt about:

- Creating your own classes
- Class inheritence
- Overriding methods
- Final classes
- Copying objects
- Deinitializers
- Mutability

The summary of the entire day was:

- Classes and structs are similar, in that they can both let you create your own types with properties and methods.
- One class can inherit from another, and it gains all the properties and methods of the parent class. It’s common to talk about class hierarchies – one class based on another, which itself is based on another.
- You can mark a class with the ```final``` keyword, which stops other classes from inheriting from it.
- Method overriding lets a child class replace a method in its parent class with a new implementation.
- When two variables point at the same class instance, they both point at the same piece of memory – changing one changes the other.
- Classes can have a deinitializer, which is code that gets run when an instance of the class is destroyed.
- Classes don’t enforce constants as strongly as structs – if a property is declared as a variable, it can be changed regardless of how the class instance was created.

**That's All for the Day 10 of 100DaysOfSwiftUI!**
