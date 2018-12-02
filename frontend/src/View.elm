module View exposing (view)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Message exposing (Message(..))
import Model exposing (Model)


view : Model -> Html Message
view model =
    div []
        [ button [ onClick PickCounty ] [ text "Give me a random county!" ]
        , div [] [ text model.county ]
        ]
