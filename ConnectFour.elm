module ConnectFour where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (..)

-- Model
type Slot = Empty | A | B

type alias Column = List Slot

type alias Board = List Column

maxColumn = 7
maxRow = 6

emptyBoard = 
  repeat maxColumn (repeat maxRow Empty)

-- View

view : Board -> Element
view board =
  flow right <| map viewColumn board
  
viewColumn column =
  flow down <| map viewSlot column

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
  List.indexedMap (updateColumn move) board
  
updateColumn (player, inColumn) index column =
  if inColumn /= index then
    column
  else
    player `dropIn` column
    
dropIn player column =
    let (empty, nonEmpty) = List.partition ((==) Empty) column
        filled = player :: nonEmpty
        empties = repeat (maxRow - (length filled)) Empty
    in empties `append` filled

    
-- Main
moves = [(A, 3), (B, 3), (A, 0), (B, 2), (A, 2), (B, 3)]

main = view <| foldl update emptyBoard moves
