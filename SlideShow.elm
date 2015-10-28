import Array exposing (fromList, get)
import Center
import Html exposing (div, a, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Graphics.Element exposing (..)
import List
import Maybe exposing (withDefault)
import StartApp.Simple as StartApp
import Slides


main =
  StartApp.start { model = model, view = view, update = update }


model = 
  { index = 0
  , slides = Slides.allSlides
  }


view address model =
  let currentSlide = 
      withDefault "" (get model.index <| fromList model.slides)
  in div []
      [ div [] [ a [ style [("position", "absolute"), ("top", "10px"), ("left", "10px")], onClick address Decrement ] [ text "Previous" ]
               , a [ style [("position", "absolute"), ("top", "10px"), ("right", "10px")], onClick address Increment ] [ text "Next" ]
               ]
      , div [] [ Center.markdown "600px" currentSlide ]
      ]


type Action = Increment | Decrement


update action model =
  case action of
    Increment -> { model | index <- (model.index + 1) % List.length(model.slides) }
    Decrement -> { model | index <- (model.index - 1) % List.length(model.slides) }
