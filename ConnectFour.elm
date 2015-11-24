module ConnectFour where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (..)
import Mouse
import Signal

-- Model
type Player = A | B

type Slot = Empty | Piece Player

type alias Column = List Slot

type alias Board = List Column

type alias Model =
  { board: Board
  , turn : Player
  }

maxColumn = 7
maxRow = 6
pieceSize = 90 -- px

emptyBoard =
  repeat maxColumn (repeat maxRow Empty)

startModel =
  { board = emptyBoard
  , turn = A
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
           Piece A -> blue
           Piece B -> red
  in collage pieceSize pieceSize
    [ circle pieceRadius |> filled (pieceColor slot)]
    |> color orange


-- Update
update : Int -> Model -> Model
update column model =
  { model |
        board = List.indexedMap (updateColumn (model.turn, column)) model.board
      , turn = nextPlayer model.turn
  }

updateColumn : (Player, Int) -> Int -> Column -> Column
updateColumn (player, inColumn) index column =
  if inColumn /= index then
    column
  else
    player `dropIn` column

dropIn : Player -> Column -> Column
dropIn player column =
    let (empty, nonEmpty) = List.partition ((==) Empty) column
        filled = 
          case empty of
            [] -> nonEmpty
            _  -> Piece player :: nonEmpty
        empties = repeat (maxRow - (length filled)) Empty
    in empties `append` filled

nextPlayer : Player -> Player
nextPlayer turn =
  case turn of
    A -> B
    B -> A

-- Signals

toColumnIndex : Int -> Int
toColumnIndex x =
  (x // pieceSize) % maxColumn

dropPieceAt : Signal Int
dropPieceAt =
  Signal.sampleOn Mouse.clicks Mouse.x

-- Main

main = Signal.map view <| Signal.foldp update startModel <| Signal.map toColumnIndex dropPieceAt
