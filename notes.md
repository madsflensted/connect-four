# Elm Copenhagen
Wedensday October 28. at Zendesk

# Elm in 2 min

## Functional
- Data is immutable
```elm
a = 1
a = 2 -- > DUPLICATE DEFINITION error
```
- Everything in an expression
```elm
f x = x * x  -- no return statement needed
```
- Types are checked at compile time and can be infered
```elm
f "hello"  -- > TYPE MISMATCH
```
- Functions cannot have side effects

## Reactive
- [Reactive in Javascript](/ReactiveGraph.elm)
- [Reactive in Elm](/ReactiveElmGraph.elm)
- The Signal type represents values that can change over time
- The Task type represents async operations that may fail

## Architecture
```elm
-- Model
...

-- View
...

-- Update
...

-- Signals
...

-- Ports
...

main = ...
```
# Getting started
- [elm-lang.org/try](http://elm-lang.org/try)
- [Install elm](http://elm-lang.org/install)
  - elm reactor
  - elm repl
  - elm make
- [share-elm.com](http://share-elm.com)


# Past the Blank Screen
- main
```elm
main : Element
-- or
main : Html
-- or equivalent Signal Element/Html
main = ...
```
- Graphics.Element.show
```elm
import Graphics.Element exposing (show)
main = show "Hello World"
```
- Debug.log
```elm
import Debug
main = show (Debug.log "Debug hello" "Hello world")
```

# Basics
- Literals - mostly what you would expect

```elm
-- number literals interpreted as Float or Int depending on context
5 // 2   -- > 2
5 / 2    -- > 2.5
5.5 // 2 -- > TYPE MISMATCH

-- Not equal
True /= False

-- Strings use "" and are not lists, use String library
String.length "Hello World"

-- Tuples use (,) and can contain different types
(1, "foo", {bar = 10}) -- tuples use (,) or (,,) or (,,,)
```

- Functions

```elm
plus x y = x + y
plus 1 2 -- > 3
1 `plus` 2 -- > 3

plus` = plus 2
plus` 3 -- > 5

plus 1 (plus 2 3)
plus 1 <| plus 2 3
plus 2 3 |> plus 1
```

# Exercises


# More ways to create views
- [Graphics.Element](http://package.elm-lang.org/packages/elm-lang/core/2.1.0/Graphics-Element)
```elm
main = 
    image 200 200 "https://avatars0.githubusercontent.com/u/4359353?v=3&s=200"
```
- [Graphics.Collage](http://package.elm-lang.org/packages/elm-lang/core/2.1.0/Graphics-Collage)
```elm
main =
    collage 300 300 [ circle 40 |> filled Color.red ]
```
- [Html](http://package.elm-lang.org/packages/evancz/elm-html/4.0.1)
```elm
main = 
    a [ (href "http://elm-lang.org/try")] [text "Try some elm!"]
```
- [Svg](http://package.elm-lang.org/packages/evancz/elm-svg/2.0.0)
```elm
main = 
    svg
      [ width "120", height "120", viewBox "0 0 120 120" ]
      [ rect [ x "10", y "10", width "100", height "100", rx "15", ry "15" ] [] ]
```
To get above to work in elm-lang/try, you need to import the respective libraries (plus their `Attributes`) and use `exposing (..)` to bring all into scope.

# Connect Four
![Connect Four Game](/connect-four-small.jpg)


# Basics
## Types
- Basic types
- Lists
- Tuples
- Records
- type alias
- union type

## Control statements
- if
- case
- let / in
- functions, define / call
- anonymous, define / call
- function application
- function composition

## Types
- infered
- annotated

# Tools
- elm make
- elm package
- [Packages](http://package.elm-lang.org/)

# Practice
- Elm examples
- Exercism.io (coming)

# Other
- [Survey](https://docs.google.com/forms/d/1_QldT91-MtDp0P1C-ymlwGwrlvMFMcVcmHw2EgxZ8jM/viewanalytics)
- Next Meetup
- Ideas for Venue?
- Ideas for group challenge
