module ConnectFour where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (..)
import Mouse
import Signal

-- Model
type Turn = PlayerA | PlayerB

type Slot = Empty | A | B

type alias Column = List Slot

type alias Board = List Column

type alias Model =
  { board: Board
  , turn : Turn
  }

maxColumn = 7
maxRow = 6
pieceSize = 90 -- px

emptyBoard =
  repeat maxColumn (repeat maxRow Empty)

startModel =
  { board = emptyBoard
  , turn = PlayerA
  }

-- View

view : Model -> Element
view model =
  flow right <| map viewColumn model.board

viewColumn column =
  flow down <| map viewSlot column

viewSlot slot =
  let pieceRadius = (pieceSize - 15) / 2
      pieceColor piece =
        case slot of
           Empty -> white
           A -> blue
           B -> red
  in collage pieceSize pieceSize
    [ circle pieceRadius |> filled (pieceColor slot)]
    |> color orange


-- Update
update : Int -> Model -> Model
update column model =
  { model |
        board <- List.indexedMap (updateColumn (model.turn, column)) model.board
      , turn <- nextPlayer model.turn
  }

updateColumn (player, inColumn) index column =
  if inColumn /= index then
    column
  else
    player `dropIn` column

dropIn player column =
    let (empty, nonEmpty) = List.partition ((==) Empty) column
        filled = (playerToSlot player) :: nonEmpty
        empties = repeat (maxRow - (length filled)) Empty
    in empties `append` filled

playerToSlot player =
  case player of
    PlayerA -> A
    PlayerB -> B

nextPlayer : Turn -> Turn
nextPlayer turn =
  case turn of
    PlayerA -> PlayerB
    PlayerB -> PlayerA

-- Signals

toColumnIndex : Int -> Int
toColumnIndex x =
  (x // pieceSize) % maxColumn

dropPieceAt : Signal Int
dropPieceAt =
  Signal.sampleOn Mouse.clicks Mouse.x

-- Main
testMoves = [(A, 3), (B, 3), (A, 0), (B, 2), (A, 2), (B, 3)]

main = Signal.map view <| Signal.foldp update startModel <| Signal.map toColumnIndex dropPieceAt
