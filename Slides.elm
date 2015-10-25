module Slides where

import Signal exposing (Signal,constant, (<~))
import Text exposing (..)
import Time
import Graphics.Element exposing (Element, centered)
import Graphics.Collage exposing (..)
import President
import Markdown

animation t = 
  collage 800 800 [
    fromString "Animations!" |> typeface ["Comic Sans MS"] 
    |> height 120 |> centered |> toForm |> rotate (sin (t/250) * 0.2)
    ]

slides: List (Signal Element)
slides =
  [ constant <| centered <| height 120 <| fromString "Use left/right arrow keys to navigate"
  , animation <~ Time.every (60*Time.millisecond)
  , constant <| centered <| height 120 <| fromString "Use up/down arrow keys to go to beginning/end"
  , constant <| mdslide
  ]

mdslide : Element
mdslide = 
  Markdown.toElement """
  ## Language

  ### Types

  ```
  1955  ---------- Int or Float depending on context
  1.21  ---------- Float
  "DeLorean"  ---- String
  'D' ------------ Char
  True || False -- Bool
  [1, 2, 3, 4] --- List
  ```
  """

main = President.present slides
