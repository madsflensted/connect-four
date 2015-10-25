module ConnectFour where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (..)

-- Model
type Slot = Empty | A | B

type alias Column = 
  { slots : List Slot }

type alias Board = 
  { columns : List Column }

maxColumn = 7
maxRow = 6
playerAcolor = blue
playerBcolor = red
emptyColor = white
boardColor = orange

emptyBoard = 
  Board (repeat maxColumn (Column (repeat maxRow Empty)))

pieceSize = 90
boardWidth = maxColumn * pieceSize
boardHeight = maxRow * pieceSize
pieceRadius = (pieceSize - 15) / 2

-- View
view : Board -> Element
view board =
  flow right <| map viewColumn board.columns
  
viewColumn column =
  flow down <| map viewSlot column.slots

viewSlot slot =  
  let pieceColor piece = 
    case slot of 
       Empty -> emptyColor
       A -> playerAcolor
       B -> playerBcolor
  in collage pieceSize pieceSize 
    [ circle pieceRadius |> filled (pieceColor slot)]
    |> color boardColor
    
    
-- Play
moves = [(A, 3), (B, 3), (A, 0), (B, 2), (A, 2), (B, 3)]

update : (Slot, Int) -> Board -> Board
update (player, column) board =
  { board | columns <- List.indexedMap (updateColumn player column) board.columns }
  
updateColumn player targetIndex index column =
  if targetIndex /= index then
    column
  else
    let (empty, rest) = List.partition (\slot -> slot == Empty) column.slots 
        newrest = player :: rest
        newempties = repeat (maxRow - (length newrest)) Empty
    in Column (newempties `append` newrest)
    
    
-- Main
main = view <| foldl update emptyBoard moves
