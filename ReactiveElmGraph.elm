import Color exposing (..)
import Graphics.Collage exposing (..)
import List
import Text as T

main = view
 
 
view = 
  collage 600 400 
    [ arrow 100
    , arrow 50
    , arrow 0
    , dot (-200, 100)
    , dot (200, 100)
    , sqr (-180, 50)
    , sqr (-120, 50)
    , tri (90, 50)
    , tri (40, 0)
    , square 14 |> outlined lineStyle |> move (-120, 50)
    , circle 6 |> outlined lineStyle |> move (-120, 100)
    , ngon 3 12 |> outlined lineStyle |> rotate (degrees -30) |> move (-120, 0)
    , box (-120, 0)
    ]
    
    
dot (x, y) =
  [ circle 5 |> filled red |> move (x, y) ]
  |> group
  
sqr (x, y) =
  [ square 10 |> filled blue |> move (x, y) ]
  |> group
  
tri (x, y) =
  [ ngon 3 10 |> filled green |> rotate (degrees -30) |> move (x, y) ]
  |> group
  
  
box (x, y) = 
  [ rect 40 260 |> outlined defaultLine
  , T.fromString "f(x)" |> T.height 20 |> T.italic |> text
    |> rotate (degrees -90) |> move (0, -60)
  , [rect 100 40 |> outlined defaultLine
    , T.fromString "View" |> T.height 20 |> text]
    |> group 
    |> move (0, -150)
  ]
  |> group
  |> move (x, y)


arrow y =
   [ traced lineStyle (segment (-250, y) (250, y))
   , ngon 3 5 |> filled black |> move (250, y)
   ]
  |> group

lineStyle =
  { defaultLine | width <- 2
                , cap <- Round }
