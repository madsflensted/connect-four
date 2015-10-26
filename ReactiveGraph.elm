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
    , dot (-180, 50)
    , dot (-120, 50)
    , dot (90, 50)
    , dot (40, 0)
    , box (-120, 0)
    ]
    
    
dot (x, y) =
  [ circle 5 |> filled black |> move (x, y) ]
  |> group
  
  
box (x, y) = 
  [ oval 50 260 |> outlined defaultLine
  , T.fromString "js" |> T.height 20 |> T.italic |> text
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
