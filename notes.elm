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

# Program
- 18.00 - 19.00, Intro to elm part I
- 19.00 - 19.15, Break beverages and Pizza
- 19.15 - 20.30, Yatzee Scorer, group work and solution sharing
- 20.45 - 21.00, Demo's

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

## Writing and compiling elm
- [elm-lang.org/try](http://elm-lang.org/try)
- [Install elm](http://elm-lang.org/install)
  - elm reactor
  - elm repl
  - elm make
- [share-elm.com](http://share-elm.com)


## Past the Blank Screen
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
main = show (Debug.log "Debug here" "Hello world")
```

# Basics
## Literals - mostly what you would expect

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
(1, "foo", {bar = 10}) -- or build using (,) or (,,) or (,,,) ...
```
[Cheat sheet for Javascript'ers](http://elm-lang.org/docs/from-javascript)

## Functions

```elm
-- No '()', no ',' and no 'return'
plus x y = x + y  -- plus take two args, types infered from use of '(+)'

plus 1 2   -- call plus with two args, notice no ','
1 `plus` 2 -- same thing, but using infix mode 

-- Partially apply function
plus' = plus 2 -- plus' is function that takes 1 argument
plus' 3        -- > 5

-- Applying functions to arguments
plus 1 (plus 2 3)  -- use '()' to group expressions
plus 1 <| plus 2 3 -- same thing using left application '(<|)'
plus 2 3 |> plus 1 -- same thing using right application '(|>)'

-- Functions as arguments
List.map plus' [1,2,3,4] -- > [3,4,5,6]

-- Anonymous functions
List.map (\\x -> x * x) [1,2,3] -- > [1, 4, 9]

```

## Union Type and Control Flow

```elm
type Relation = LT | EQ | GT

relationTo x y =
  if x > y then
    GT
  else if x == y then
    EQ
  else
    LT

showRelation relation =
  case relation of
    GT -> "Greater than"
    EQ -> "Equal"
    LT -> "Less than"

main = show <| showRelation <| relationTo 10 100
```

## Records, Type Alias and Scoping

```elm
type Relation = Friend | FriendOfFriend String | Stranger

peter = { name = "Peter", relation = Friend }

type alias Contact = 
  { name : String
  , relation : Relation
  }

lucy = Contact "Lucy" Friend  -- type constructor
anna = Contact "Anna" (FriendOfFriend "Peter")
bob = { anna | name <- "Bob" }  -- syntax changing in 0.16.0 !
eric = Contact "Eric" Stranger

greeting contact =
  let prefix = 
      case contact.relation of
        Stranger -> "Hello "
        _ -> "Hi "

      append =
        case .relation contact of  -- (.name) to access field of record
          Friend -> " my friend"
          FriendOfFriend name -> " friend of " ++ name
          Stranger -> ""

  in prefix ++ contact.name ++ append

main = show <| List.map greeting [peter, anna, lucy, bob, eric]
```
[Record documentation](http://elm-lang.org/guide/core-language#records) - but be aware of upcoming syntax changes

## Type annotations

```elm
greeting : Contact -> String
gretting contact =
  ...

name : { name : String } -> String
name person =
  ...

filter : List Contact -> Relation -> List Contact
filter contacts relation = 
  ...

-- TIP: inspect types by deliberatly breaking things
main = show <| 1 + "hello"
```

<div><div style="white-space: pre; font-size: 14px;"><div style="border-top: 2px solid black; height: 40px;"><h2 style="margin: 10px 0px 0px; display: inline-block;">TYPE MISMATCH</h2><a style="float: right; padding: 1em;" href="javascript:void(0)">jump to error</a></div><p><code>The right argument of (+) is causing a type mismatch.</code></p><div style="padding: 1em 0px; background-color: rgb(230, 230, 230);"><code><div><span style="color: rgb(166, 131, 131);">5| </span>main = show &lt;| 1 + <span style="color: red;">"hello"</span></div></code></div><p><code>As I infer the type of values flowing through your program, I see a conflict
between these two types:

    number

    String
</code></p><br></div></div>


# Exercises

## Connect Four
![Connect Four Game](/connect-four-small.jpg)


# Closing part I
## More ways to create views
- [Graphics.Element](http://package.elm-lang.org/packages/elm-lang/core/2.1.0/Graphics-Element)
```elm
main = 
    image 200 200
      "https://avatars0.githubusercontent.com/u/4359353?v=3&s=200"
```
- [Graphics.Collage](http://package.elm-lang.org/packages/elm-lang/core/2.1.0/Graphics-Collage)
```elm
main =
    collage 300 300 [ circle 40 |> filled Color.red ]
```
- [Html](http://package.elm-lang.org/packages/evancz/elm-html/4.0.1)
```elm
main = 
    a [ (href "http://elm-lang.org/try") ] [ text "Try some elm!" ]
```
- [Svg](http://package.elm-lang.org/packages/evancz/elm-svg/2.0.0)
```elm
main = 
    svg
      [ width "120", height "120", viewBox "0 0 120 120" ]
      [ rect 
        [ x "10"
        , y "10"
        , width "100"
        , height "100"
        , rx "15"
        , ry "15" 
        ] [] 
      ]
```
To get above to work in elm-lang/try, you need to import the respective libraries (plus their `Attributes`) and use `exposing (..)` to bring all into scope.

## Tools
- [Package repository](http://package.elm-lang.org/)
```elm
elm package install evancz/elm-html
```
- [elm test](https://github.com/rtfeldman/node-elm-test)
```elm
npm install elm-test
```

## Practice
- [Elm examples](http://elm-lang.org/examples)
- [Elm challenges](https://github.com/pdamoc/elmChallenges)
- WIP: [Elm exercises on Exercism.io](https://github.com/bewatts/xelm)
  - Help out if you have some time!

# Next Meetups
- [Survey](https://docs.google.com/forms/d/1_QldT91-MtDp0P1C-ymlwGwrlvMFMcVcmHw2EgxZ8jM/viewanalytics)
- Next Meetup
  - Wedensday November 25.
  - at BestBrains [Sankt Gertruds Stræde 5, 3.sal - 1129 København K](https://www.google.dk/maps/place/Sankt+Gertruds+Str%C3%A6de+5,+1129+K%C3%B8benhavn+K/@55.683257,12.5718373,17z/data=!4m7!1m4!3m3!1s0x4652531ac7052ecf:0xcf513d8978fa1e4d!2sSankt+Gertruds+Str%C3%A6de+5,+1129+K%C3%B8benhavn+K!3b1!3m1!1s0x4652531ac7052ecf:0xcf513d8978fa1e4d)
- January meeting
  - Idea for Venue?
  - Last Wednsday of the month?
- Ideas for group challenges?

# Break

# Group Challenge
![Yatzy](/Yatzy_Score_card_with_dies.jpg)
- [Scoring rules](https://en.wikipedia.org/wiki/Yatzy#Scoring)
- Unit tests: https://github.com/jacobat/elm-yatzy

"""
