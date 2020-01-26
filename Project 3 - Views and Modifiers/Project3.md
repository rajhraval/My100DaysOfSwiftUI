## Project 3 - Views And Modifiers - 100DaysOfSwiftUI Challenge

### Project 3 - Day One - Day 23 of 100DaysOfSwiftUI

> There is no magic in magic, it’s all in the details. - Walt Disney

Today I learnt about:
- Introduction and Project Setup
- Why SwiftUI uses structs for its Views?
- What is behind the main SwiftUI View?
- Why order of modifiers matters?
- Why does SwiftUI use `some View` for it's view type?
- Conditionals Modifiers
- Environmental Modifiers
- Views as Properties
- View Compositions
- Custom Modifiers
- Custom Containers

### Project 3 - Day Two - Day 24 of 100DaysOfSwiftUI

> Any fool can know; the point is to understand - Albert Einstein

Today I completed the challenges:
- Adding a custom modifier conforming to `ViewModifier` protocol having a large title with blue font suitable for prominent title.
- Using a conditional modifier in Project 1 - WeSplit - To make the Grand Total text go red if the tip percentage selected is 0%
- Creating a FlagImage view composition in Project 2, which renders the flag.

Project 3 - Summary:

I have learnt about Views and Modifiers:

1. SwiftUI uses structs for elemental performance, No Extra Values as compared to Classes and not to inherit methods and properties.

2. SwiftUI View Structs forces us to think about isolating struct in clean way.

3. Encourages for more functional design approach.

4. There is nothing behind the SwiftUI View. (UIHostingController is behind the scenes of the Content View).

5. Each modifier creates new view rather than setting the property in the view.

6. Order of your modifier matters.

7. When working with custom modifiers, it’s usually a smart idea to create extensions on View that make them easier to use.

8. There are many ways to create complex view hierarchies:
  
| Way | How to do it? |
| -- | -- |
| Views Properties  |  Creating Property of your own View, then use it inside layouts. Swift doesn’t let us create one stored property that refers to other stored properties, because it would cause problems when the object is created. This means trying to create a TextField bound to a local property will cause problems. |
| View Compositions | Wrapping identical views into one similar view by using Struct. |

9. There are two ways of using Custom Modifiers:

|Way  | How to do it? |
|--|--|
| `.modifier(yourModifierName())` | Creating a struct that conforms to the ViewModifier Protocol, you will use a modifier named modifier and embed the name of the Struct to use it. |
| `.modiferName()` | Wrapping the Struct Using Extensions, then creating a function returning some view and using the name of the function as the modifier name.  |
  
10. We can also create custom containers with Advanced Swift features like Generics, you can leverage it using SwiftUI View Builders which allows us to send in several views and have it form an implicit stack for us.

11. Local modifiers always override environment modifiers from the parent.
