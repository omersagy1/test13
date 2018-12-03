module View exposing (view)

import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Message exposing (Message(..))
import Model exposing (Model)


view : Model -> Html Message
view model =
    div []
        [ button [ onClick PickCounty ] [ text "Give me a random county!" ]
        , div [] [ text model.county ]
        , populationSearch (Maybe.withDefault 0 (String.toInt model.population))
        ]


populationSearch : Int -> Html Message
populationSearch currentValue =
    div []
        [ button [ onClick (SearchPopulation currentValue) ] [ text "City with population nearest to:" ]
        , input
            [ placeholder "10000"
            , value (String.fromInt currentValue)
            , onInput ChangePopulation
            ]
            []
        ]
