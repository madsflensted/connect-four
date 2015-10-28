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

emptyBoard = 
  Board (repeat maxColumn (Column (repeat maxRow Empty)))

-- View

view : Board -> Element
view board =
  flow right <| map viewColumn board.columns
  
viewColumn column =
  flow down <| map viewSlot column.slots

viewSlot slot =  
  let pieceSize = 90
      pieceRadius = (pieceSize - 15) / 2
      pieceColor piece = 
        case slot of 
           Empty -> white
           A -> blue
           B -> red
  in collage pieceSize pieceSize 
    [ circle pieceRadius |> filled (pieceColor slot)]
    |> color orange
    
    
-- Update
update : (Slot, Int) -> Board -> Board
update move board =
  { board | columns <- List.indexedMap (updateColumn move) board.columns }
  
updateColumn (player, inColumn) index column =
  if inColumn /= index then
    column
  else
    player `dropIn` column
    
dropIn player column =
    let (empty, nonEmpty) = List.partition ((==) Empty) column.slots 
        filled = player :: nonEmpty
        empties = repeat (maxRow - (length filled)) Empty
    in Column (empties `append` filled)

    
-- Main
moves = [(A, 3), (B, 3), (A, 0), (B, 2), (A, 2), (B, 3)]

main = view <| foldl update emptyBoard moves
