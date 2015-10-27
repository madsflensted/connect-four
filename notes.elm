import Html exposing (..)
import Html.Attributes exposing (..)

import Center


port title : String
port title = "ELMCPH"


(=>) = (,)


main = Center.markdown "600px" content


content = """

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
# Connect Four
![Connect Four Game](/connect-four-small.jpg)

# Getting started
- [elm-lang.org/try](http://elm-lang.org/try)
- [Install elm](http://elm-lang.org/install)
  - elm-reactor
  - elm-repl
- [share-elm.com](http://share-elm.com)


# Blank screen
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
- elm-repl
```elm
a = "Hello"
"Hello" : String
```

# Exercises


# Filling the screen
- Graphics.Element
- Graphics.Collage
- Html
- Svg

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

# Practice
- Elm examples
- Exercism.io (coming)

# Other
- [Survey](https://docs.google.com/forms/d/1_QldT91-MtDp0P1C-ymlwGwrlvMFMcVcmHw2EgxZ8jM/viewanalytics)
- Next Meetup
- Ideas for Venue?
- Ideas for group challenge

"""
